/*
================================================================================
|
|   app/courses/create/ClientCreateCourse.tsx
|
|   (Bản cập nhật - Gộp Stepper 2 & 3, Bỏ Stepper 4, Bỏ trường Level)
|
|   - Chỉ còn 2 bước: "Basic Information" và "Advance Information".
|   - "Advance Information" giờ bao gồm cả Status, Duration VÀ Curriculum Bank.
|   - Trường "Level" đã bị xóa.
|   - Nút "Save Course" xuất hiện ở cuối bước 2.
|
================================================================================
*/
"use client"

import React, { useState, useMemo } from "react"
// import { useRouter } from "next/navigation" // <-- ĐÃ VÔ HIỆU HÓA ĐỂ PREVIEW

// --- Icons ---
import {
  GripVertical,
  BookOpen, // Icon cho Lesson
  FileQuestion, // Icon cho Quiz
  Search,
  Edit2,
  Trash2,
  X,
  Plus,
  PlusCircle,
} from "lucide-react"
import { Input, Button, Steps, Modal, Tabs, Select, message } from "antd"
import {
  SearchOutlined,
  DeleteOutlined,
  EditOutlined,
  PlusOutlined,
  PlusCircleOutlined,
  CloseOutlined,
} from "@ant-design/icons"

const { TextArea } = Input

// --- 1. ĐỊNH NGHĨA CÁC TYPES ---

export type Lesson = {
  id: number
  title: string
  duration_minutes: number
}
export type Quiz = {
  id: number
  title: string
  question_count: number
}

export type CurriculumItem = {
  id: string
  order: number
  resource_id: number
  type: "lesson" | "quiz"
  title: string
  duration_minutes?: number
  question_count?: number
}

export type Section = {
  id: string
  title: string
  order: number
  items: CurriculumItem[]
}

type CoursePayload = {
  title?: string
  slug?: string
  description?: string
  thumbnail_url?: string
  status?: string
  duration_hours?: number
  language?: string
  // level?: string // <-- VẪN GIỮ TRONG TYPE (có thể cần cho DB), NHƯNG XÓA KHỎI UI
  price?: number | null
  tags?: string[]
  curriculum: Section[]
}

// (THAY ĐỔI) Chỉ còn 2 bước
const steps = [
  "Basic Information",
  "Advance Information", // Bước này giờ bao gồm cả Curriculum
]

type StepStatus = "pending" | "valid" | "invalid"

// --- DỮ LIỆU GIẢ ---
const MOCK_LESSONS: Lesson[] = [
  { id: 101, title: "Bài 1: Giới thiệu React", duration_minutes: 15 },
  { id: 102, title: "Bài 2: Components và Props", duration_minutes: 25 },
  { id: 103, title: "Bài 3: State và Lifecycle", duration_minutes: 30 },
]
const MOCK_QUIZZES: Quiz[] = [
  { id: 201, title: "Quiz 1: Kiến thức cơ bản", question_count: 5 },
  { id: 202, title: "Quiz 2: Kiểm tra State", question_count: 10 },
]

// --- 2. COMPONENT CHÍNH ---

export default function ClientCreateCourse() {
  // const router = useRouter() // <-- Vô hiệu hóa
  const [current, setCurrent] = useState(0)
  const [loading, setLoading] = useState(false)

  const [payload, setPayload] = useState<CoursePayload>({
    status: "draft",
    duration_hours: 0,
    tags: [],
    curriculum: [],
  })

  // (THAY ĐỔI) State giờ có độ dài là 2
  const [stepStatus, setStepStatus] = useState<StepStatus[]>(
    new Array(steps.length).fill("pending") // steps.length giờ là 2
  )

  // Hàm update chung (không đổi)
  function update<K extends keyof CoursePayload>(
    key: K,
    value: CoursePayload[K]
  ) {
    setPayload((p) => ({ ...p, [key]: value }))
    if (stepStatus[current] === "invalid") {
      setStepStatus((prevStatus) => {
        const newStatus = [...prevStatus]
        newStatus[current] = "pending"
        return newStatus
      })
    }
  }

  // Hàm validate (THAY ĐỔI: Gộp logic case 1 và 2 cũ, bỏ Level)
  function validateStep(stepIndex: number): boolean {
    switch (stepIndex) {
      case 0: // Basic Information
        return !!payload.title?.trim() && !!payload.slug?.trim()
      case 1: // Advance Information (Giờ bao gồm cả Curriculum)
        // Kiểm tra Curriculum
        const isValidCurriculum =
          payload.curriculum.length > 0 &&
          payload.curriculum.every((s) => s.items.length > 0)
        // (Không cần kiểm tra Level nữa)
        // Bạn có thể thêm kiểm tra cho Status hoặc Duration nếu muốn
        return isValidCurriculum // Chỉ kiểm tra Curriculum là bắt buộc ở bước này
      default:
        return false
    }
  }

  // Hàm changeStep (không đổi)
  function changeStep(newIndex: number) {
    if (newIndex === current || newIndex < 0 || newIndex >= steps.length) {
      return
    }
    const isCurrentStepValid = validateStep(current)
    setStepStatus((prevStatus) => {
      const newStatus = [...prevStatus]
      newStatus[current] = isCurrentStepValid ? "valid" : "invalid"
      return newStatus
    })
    setCurrent(newIndex)
  }

  function next() {
    changeStep(current + 1)
  }

  function prev() {
    changeStep(current - 1)
  }

  // Hàm handleSubmit (không đổi)
  async function handleSubmit() {
    // 1. Validate tất cả các bước (giờ chỉ có 2 bước)
    const allStepsValidResults = steps.map((_, i) => validateStep(i))
    const isAllValid = allStepsValidResults.every((isValid) => isValid)

    // 2. Cập nhật status UI
    setStepStatus((prevStatus) => {
      return prevStatus.map((status, i) =>
        allStepsValidResults[i] ? "valid" : "invalid"
      )
    })

    // 3. Nếu không hợp lệ, nhảy về bước lỗi đầu tiên
    if (!isAllValid) {
      const firstInvalidStep = allStepsValidResults.findIndex((valid) => !valid)
      if (firstInvalidStep !== -1) {
        setCurrent(firstInvalidStep)
      }
      message.error(
        "Vui lòng hoàn thành tất cả các trường bắt buộc ở mọi bước trước khi đăng."
      )
      return
    }

    // 4. Nếu hợp lệ, tiến hành submit
    setLoading(true)
    try {
      console.log("Submitting payload:", JSON.stringify(payload, null, 2))
      await new Promise((resolve) => setTimeout(resolve, 1000))
      console.log("Submit thành công! Đang chuyển hướng...")
      // router.push("/manage/courses") // <-- Vô hiệu hóa
    } catch (err) {
      console.error(err)
    } finally {
      setLoading(false)
    }
  }

  // Đếm tổng số items (không đổi)
  const totalItems = payload.curriculum.reduce(
    (acc, section) => acc + section.items.length,
    0
  )

  return (
    <div className="bg-white p-6 rounded shadow">
      {/* Header (Cập nhật số bước) */}
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-2xl font-semibold">Create a new course</h1>
        <div className="text-sm text-gray-500">
          {/* (THAY ĐỔI) steps.length giờ là 2 */}
          Step {current + 1} / {steps.length}
        </div>
      </div>

      {/* Stepper bar (Tự động cập nhật còn 2 bước) */}
      <div className="mb-6">
        <Steps
          current={current}
          onChange={changeStep}
          items={steps.map((s, i) => {
            const status = stepStatus[i]
            const isCurriculumStep = s === "Advance Information" && i === 1
            return {
              title: s,
              status:
                status === "valid"
                  ? "finish"
                  : status === "invalid"
                    ? "error"
                    : "wait",
              description: isCurriculumStep ? `${totalItems} items` : undefined,
            }
          })}
        />
      </div>

      {/* Vùng nội dung của Stepper */}
      <div>
        {/* --- STEP 1: BASIC INFORMATION (không đổi) --- */}
        {current === 0 && (
          <section className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-1">Title</label>
              <Input
                value={payload.title || ""}
                onChange={(e) => update("title", e.target.value)}
                status={
                  stepStatus[0] === "invalid" && !payload.title?.trim()
                    ? "error"
                    : ""
                }
                placeholder="Enter course title"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Slug</label>
              <Input
                value={payload.slug || ""}
                onChange={(e) => update("slug", e.target.value)}
                status={
                  stepStatus[0] === "invalid" && !payload.slug?.trim()
                    ? "error"
                    : ""
                }
                placeholder="Enter course slug"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">
                Thumbnail URL
              </label>
              <Input
                value={payload.thumbnail_url || ""}
                onChange={(e) => update("thumbnail_url", e.target.value)}
                placeholder="Enter thumbnail URL"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">
                Short Description
              </label>
              <TextArea
                value={payload.description || ""}
                onChange={(e) => update("description", e.target.value)}
                rows={4}
                placeholder="Enter course description"
              />
            </div>
          </section>
        )}

        {/* --- STEP 2: ADVANCE INFORMATION (Gộp nội dung cũ của Step 2 & 3, bỏ Level) --- */}
        {current === 1 && (
          <section className="space-y-6">
            {" "}
            {/* Tăng khoảng cách giữa các phần */}
            {/* Phần Thông tin cũ của Step 2 (Bỏ Level) */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium mb-1">Status</label>
                <Select
                  value={payload.status}
                  onChange={(value) => update("status", value)}
                  className="w-full"
                  options={[
                    { value: "draft", label: "Draft" },
                    { value: "published", label: "Published" },
                    { value: "archived", label: "Archived" },
                  ]}
                />
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Duration (hours)
                </label>
                <Input
                  type="number"
                  value={String(payload.duration_hours ?? 0)}
                  onChange={(e) =>
                    update("duration_hours", Number(e.target.value))
                  }
                />
              </div>
              {/* Trường Level đã bị xóa */}
            </div>
            {/* Đường kẻ ngang phân cách */}
            <hr className="my-6 border-gray-200" />
            {/* Phần Curriculum (Nội dung cũ của Step 3) */}
            <div>
              <CurriculumContentBank
                availableLessons={MOCK_LESSONS}
                availableQuizzes={MOCK_QUIZZES}
                value={payload.curriculum}
                onChange={(newCurriculum) =>
                  update("curriculum", newCurriculum)
                }
                hasError={
                  stepStatus[1] === "invalid" && // (THAY ĐỔI) Kiểm tra status của bước hiện tại (1)
                  (payload.curriculum.length === 0 ||
                    payload.curriculum.some((s) => s.items.length === 0))
                }
              />
              {stepStatus[1] === "invalid" && ( // (THAY ĐỔI) Kiểm tra status của bước hiện tại (1)
                <p className="mt-2 text-sm text-red-600">
                  Curriculum must have at least one section, and each section
                  must have at least one item (lesson or quiz).
                </p>
              )}
            </div>
          </section>
        )}
      </div>

      {/* Nút điều hướng (THAY ĐỔI: Logic hiển thị nút cuối) */}
      <div className="mt-6 flex items-center justify-between">
        <div>{current > 0 && <Button onClick={prev}>Back</Button>}</div>
        <div>
          {/* Nếu chưa phải bước cuối (Advance Info), hiển thị "Next" */}
          {current < steps.length - 1 ? ( // steps.length - 1 giờ là 1
            <Button type="primary" onClick={next}>
              Next
            </Button>
          ) : (
            // Nếu đang ở bước cuối (Advance Info), hiển thị "Save Course"
            <Button
              type="primary"
              onClick={handleSubmit}
              loading={loading}
              style={{ backgroundColor: "#10b981" }}
            >
              Save Course
            </Button>
          )}
        </div>
      </div>
    </div>
  )
}

// --- Component CurriculumContentBank (Không thay đổi) ---
interface CurriculumContentBankProps {
  value: Section[]
  onChange: (value: Section[]) => void
  hasError: boolean
  availableLessons: Lesson[]
  availableQuizzes: Quiz[]
}

function CurriculumContentBank({
  value: sections,
  onChange,
  hasError,
  availableLessons,
  availableQuizzes,
}: CurriculumContentBankProps) {
  const [modalState, setModalState] = useState<{
    type: "Section"
    sectionId?: string
  } | null>(null)

  const [activeTab, setActiveTab] = useState<"lessons" | "quizzes">("lessons")
  const [searchTerm, setSearchTerm] = useState("")

  // --- Hàm xử lý Section ---
  const handleAddSection = () => {
    setModalState({ type: "Section" })
  }

  const handleEditSection = (sectionId: string) => {
    setModalState({ type: "Section", sectionId })
  }

  const handleSaveSection = (title: string) => {
    if (modalState?.sectionId) {
      onChange(
        sections.map((s) =>
          s.id === modalState.sectionId ? { ...s, title } : s
        )
      )
    } else {
      const newSection: Section = {
        id: crypto.randomUUID(),
        title: title || `Section ${sections.length + 1}: New Section`,
        order: sections.length + 1,
        items: [],
      }
      onChange([...sections, newSection])
    }
    setModalState(null)
  }

  const handleDeleteSection = (sectionId: string) => {
    onChange(sections.filter((s) => s.id !== sectionId))
  }

  // --- Hàm xử lý Item ---
  const handleAddItemToSection = (
    sectionId: string,
    item: Lesson | Quiz,
    type: "lesson" | "quiz"
  ) => {
    onChange(
      sections.map((s) => {
        if (s.id !== sectionId) return s
        const newItem: CurriculumItem = {
          id: crypto.randomUUID(),
          order: s.items.length + 1,
          resource_id: item.id,
          type: type,
          title: item.title,
          ...(type === "lesson" && {
            duration_minutes: (item as Lesson).duration_minutes,
          }),
          ...(type === "quiz" && {
            question_count: (item as Quiz).question_count,
          }),
        }
        return { ...s, items: [...s.items, newItem] }
      })
    )
  }

  const handleRemoveItem = (sectionId: string, itemId: string) => {
    onChange(
      sections.map((s) =>
        s.id === sectionId
          ? { ...s, items: s.items.filter((i) => i.id !== itemId) }
          : s
      )
    )
  }

  // --- Logic lọc ---
  const filteredLessons = useMemo(
    () =>
      availableLessons.filter((l) =>
        l.title.toLowerCase().includes(searchTerm.toLowerCase())
      ),
    [availableLessons, searchTerm]
  )

  const filteredQuizzes = useMemo(
    () =>
      availableQuizzes.filter((q) =>
        q.title.toLowerCase().includes(searchTerm.toLowerCase())
      ),
    [availableQuizzes, searchTerm]
  )

  return (
    <div
      className={`grid grid-cols-1 md:grid-cols-2 gap-6 p-4 border rounded-md ${
        hasError ? "border-red-500" : "border-gray-200"
      }`}
    >
      {/* CỘT TRÁI */}
      <div className="bg-gray-50 p-4 rounded border h-[600px] flex flex-col">
        <h3 className="text-lg font-semibold mb-4">Available Content</h3>
        <div className="relative mb-2">
          <input
            type="text"
            placeholder="Search content..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-8 pr-4 py-2 border rounded-md text-sm"
          />
          <Search
            size={16}
            className="absolute left-2.5 top-2.5 text-gray-400"
          />
        </div>
        <div className="flex border-b mb-2">
          <button
            onClick={() => setActiveTab("lessons")}
            className={`px-4 py-2 text-sm font-medium ${
              activeTab === "lessons"
                ? "border-b-2 border-blue-600 text-blue-600"
                : "text-gray-500"
            }`}
          >
            Lessons ({filteredLessons.length})
          </button>
          <button
            onClick={() => setActiveTab("quizzes")}
            className={`px-4 py-2 text-sm font-medium ${
              activeTab === "quizzes"
                ? "border-b-2 border-blue-600 text-blue-600"
                : "text-gray-500"
            }`}
          >
            Quizzes ({filteredQuizzes.length})
          </button>
        </div>
        <div className="flex-1 overflow-y-auto space-y-2">
          {activeTab === "lessons" &&
            filteredLessons.map((lesson) => (
              <ContentBankItem
                key={lesson.id}
                icon={<BookOpen size={16} />}
                title={lesson.title}
                meta={`${lesson.duration_minutes} min`}
                onAdd={() => {
                  if (sections.length > 0) {
                    // (THAY ĐỔI) Thêm vào section cuối cùng thay vì section[0]
                    handleAddItemToSection(
                      sections[sections.length - 1].id,
                      lesson,
                      "lesson"
                    )
                  } else {
                    console.warn("Vui lòng tạo Section trước khi thêm nội dung")
                  }
                }}
              />
            ))}
          {activeTab === "quizzes" &&
            filteredQuizzes.map((quiz) => (
              <ContentBankItem
                key={quiz.id}
                icon={<FileQuestion size={16} />}
                title={quiz.title}
                meta={`${quiz.question_count} questions`}
                onAdd={() => {
                  if (sections.length > 0) {
                    // (THAY ĐỔI) Thêm vào section cuối cùng thay vì section[0]
                    handleAddItemToSection(
                      sections[sections.length - 1].id,
                      quiz,
                      "quiz"
                    )
                  } else {
                    console.warn("Vui lòng tạo Section trước khi thêm nội dung")
                  }
                }}
              />
            ))}
        </div>
      </div>

      {/* CỘT PHẢI */}
      <div className="bg-white rounded h-[600px] flex flex-col">
        <h3 className="text-lg font-semibold mb-4">Course Curriculum</h3>
        <div className="flex-1 overflow-y-auto space-y-4">
          {sections.map((section) => (
            <div key={section.id} className="bg-white border rounded">
              <div className="flex items-center justify-between p-3 border-b bg-gray-50">
                <div className="flex items-center gap-2">
                  <GripVertical size={18} className="text-gray-400" />
                  <span className="font-medium">{section.title}</span>
                </div>
                <div className="flex items-center gap-3">
                  <button
                    onClick={() => handleEditSection(section.id)}
                    className="text-gray-500 hover:text-blue-600"
                  >
                    <Edit2 size={16} />
                  </button>
                  <button
                    onClick={() => handleDeleteSection(section.id)}
                    className="text-gray-500 hover:text-red-600"
                  >
                    <Trash2 size={16} />
                  </button>
                </div>
              </div>
              <div className="p-3 space-y-2">
                {section.items.map((item) => (
                  <div
                    key={item.id}
                    className="flex items-center justify-between p-2 border rounded hover:bg-gray-50"
                  >
                    <div className="flex items-center gap-2">
                      <GripVertical size={16} className="text-gray-400" />
                      {item.type === "lesson" ? (
                        <BookOpen size={16} className="text-gray-500" />
                      ) : (
                        <FileQuestion size={16} className="text-gray-500" />
                      )}
                      <span className="text-sm">{item.title}</span>
                    </div>
                    <div className="flex items-center gap-3">
                      <span className="text-xs text-gray-400">
                        {item.type === "lesson"
                          ? `${item.duration_minutes} min`
                          : `${item.question_count} Qs`}
                      </span>
                      <button
                        onClick={() => handleRemoveItem(section.id, item.id)}
                        className="text-gray-500 hover:text-red-600"
                      >
                        <X size={15} />
                      </button>
                    </div>
                  </div>
                ))}
                {section.items.length === 0 && (
                  <p className="text-sm text-gray-500 px-2 py-4 text-center">
                    (Kéo hoặc thả nội dung từ cột trái vào đây)
                  </p>
                )}
              </div>
            </div>
          ))}
          {sections.length === 0 && (
            <p className="text-sm text-gray-500 px-2 py-16 text-center">
              Click "Add Section" to start building your curriculum.
            </p>
          )}
        </div>
        <div className="mt-4">
          <button
            type="button"
            onClick={handleAddSection}
            className="w-full flex items-center justify-center gap-2 p-3 border-2 border-dashed border-gray-300 rounded text-gray-600 hover:border-blue-500 hover:text-blue-600"
          >
            <Plus size={18} />
            Add Section
          </button>
        </div>
      </div>

      {/* MODAL */}
      {modalState?.type === "Section" && (
        <FormModal
          title={modalState.sectionId ? "Edit Section Name" : "Add New Section"}
          label="Section"
          placeholder="Write your section name here..."
          initialValue={
            modalState.sectionId
              ? sections.find((s) => s.id === modalState.sectionId)?.title
              : ""
          }
          onClose={() => setModalState(null)}
          onSave={handleSaveSection}
        />
      )}
    </div>
  )
}

// --- Component ContentBankItem (Không thay đổi) ---
function ContentBankItem({
  icon,
  title,
  meta,
  onAdd,
}: {
  icon: React.ReactNode
  title: string
  meta: string
  onAdd: () => void
}) {
  return (
    <div className="flex items-center justify-between p-2 bg-white border rounded shadow-sm">
      <div className="flex items-center gap-2 overflow-hidden">
        <span className="text-blue-600">{icon}</span>
        <div className="flex-1 overflow-hidden">
          <p className="text-sm font-medium truncate">{title}</p>
          <p className="text-xs text-gray-500">{meta}</p>
        </div>
      </div>
      <button onClick={onAdd} className="text-blue-500 hover:text-blue-700 p-1">
        <PlusCircle size={18} />
      </button>
    </div>
  )
}

// --- Component FormModal (Không thay đổi) ---
function FormModal({
  title,
  label,
  placeholder,
  initialValue = "",
  onClose,
  onSave,
}: {
  title: string
  label: string
  placeholder: string
  initialValue?: string
  onClose: () => void
  onSave: (value: string) => void
}) {
  const [value, setValue] = useState(initialValue)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    onSave(value)
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg shadow-xl w-full max-w-md">
        <form onSubmit={handleSubmit}>
          <div className="flex justify-between items-center p-4 border-b">
            <h3 className="text-lg font-semibold">{title}</h3>
            <button
              type="button"
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600"
            >
              <X size={20} />
            </button>
          </div>
          <div className="p-4 space-y-2">
            <label htmlFor="modal-input" className="block text-sm font-medium">
              {label}
            </label>
            <input
              id="modal-input"
              type="text"
              value={value}
              onChange={(e) => setValue(e.target.value)}
              placeholder={placeholder}
              className="w-full border px-3 py-2 rounded border-gray-300"
              autoFocus
            />
          </div>
          <div className="flex justify-end gap-3 p-4 bg-gray-50 rounded-b-lg">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 bg-white border rounded text-sm font-medium"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-4 py-2 bg-blue-600 text-white rounded text-sm font-medium"
            >
              Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

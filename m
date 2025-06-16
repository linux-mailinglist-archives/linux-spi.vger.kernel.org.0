Return-Path: <linux-spi+bounces-8570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D6ADAE25
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C7A16C3B9
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C692D1914;
	Mon, 16 Jun 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4lgbJp/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66A2C15BA
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072721; cv=none; b=LNqxAKO9nmNbtZIQ8hpzx8OyjblJi5v25hEkPGTChZfQaVUZlaE3P3f93ODwC+YHMY6f4DmBsCXMXPvTWyxkD9pNUQV5twgT/owfr9JR2ezAIKn6h3YaNOzRRSqd5hDVSU9O+kOt7XN3ym+mz2A6T5pP/AfTgEjeyoqxnAHYquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072721; c=relaxed/simple;
	bh=hrasx9LpaBhIfwmbsVUucBku/W+eFelK4E1GYnytmA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Av2XBEY6g2hqKfm2J/GccgCIvbVcromHTk7XJHSdO1bobYCdzczASR0XgGWNOdiPlpptPmqjyQREmSdaYSsXrjJSYSa2+19tHuMyRaISh+VPFDQKZCPNRpzu3ycm7rdyjswYKf9u0g+bIbNyraq6UltpavG09tbvK36cpuvBZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4lgbJp/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4533bf4d817so10629435e9.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750072718; x=1750677518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFRRbT8s9vGTGk+mkini82Ing/hSasgp2YN4IKINJ8I=;
        b=w4lgbJp/viQVmzvRxgkhM9UhM3iz2JmbxdsPct7cvo8zQX3RCSyH1YcPcrpTAIZvCp
         EORrCCBbytOQfBQ8UiUMd6DWVq569vBaVA+iIzrzzOLcW6A4DjNTAstu2ng8xIbzu+pz
         O2o/kW9ndjvkfExHnRNNNFQnUXnsv0oU/543bT5O7Mo3PPorsREjdkmO6WZhkCt5gtQs
         TgL9dq7brMN+lFB95n3x1gRKSlnhCqPbL8Vwbf+C80aWKSrog8UJTQD5xDISBTA/YuYK
         CxUSwgJhQZAH3j+lHVXWgPzCjJlDa9JPRtu66yrypYj1Ga4VgC7jIUwgQ6Yy241C02m0
         kFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072718; x=1750677518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFRRbT8s9vGTGk+mkini82Ing/hSasgp2YN4IKINJ8I=;
        b=ErQJtiTI93wj0fxUBPF99592DkGe/gKRuvLFNd2a43Iyp+gi7Cpv+q4VZrn8y8TAyb
         /K0S1kyzYy0IM16N/aI6p/tj9vm/IHkVqzW5gqIj/hqgvoGEmckJ9WjOs/+9u6Gd+JiA
         FJfhrifVW8KHZYLWBMbI0y+/903GPWRuELi5gEFwDQV0QCqpmBHq6Llh7pbMLqLG+Ews
         m5noRGpcad4IAahlq9ev02Imexp1rIbFDMYz5PTTwwcMFhPvRo0rWQ0ThWCE5RijytEt
         B3m04kkJd9NPDN+cbJoF9c7/i/zr0cP2wc41DQMCx10pQ6EFEMPd4XLooWphfa7ZURYS
         I0fA==
X-Forwarded-Encrypted: i=1; AJvYcCXAgyEzb1ovqB64qce8W8quJtgBe37QOAmTy9r3sUbiOTcZaRNwbbck7O+Msfx/ho3mj6MmjZMVsfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvi6OJzJjG0ulwqMMUyk1Pxv+f8VOryG2H4Onqb3WzcajiS+pP
	pVkZ9sa8bnKPCD1yxwbRkjTLFsyXaHR58/L/3Kt/wqn1kJL4syDbcMogLSlu72b6djM=
X-Gm-Gg: ASbGncsppXRQEZyzvcUW9P6c7EA5GI42yRf+cMaPLom3ZH/UFOm9WEnGfZYU/IxcPyn
	SVFs9vZ59r2nGEYaWVxE+bE7IVNEFTLcnAfuFAS4ZHJqLhP8aPJIUkxJ8UGWnwkiZbWD9b+I3Ke
	1XjimRSfUyf3lgH+lkmiZlPckeTBTb+JUF1bfbWr6DPXigOJ9LyxWNHOC32f680LyKafSXHyop8
	zjH6lV/OHOcbpLRgtadhiLtdl7lvokd/eHLLaachaX+32UA5usnsiIClmHBaIQ5EvY3r9kDK6Q+
	wjPn1IrcN6s89eE14DA0dbgVLTiQdjnLZ0jIZFsH8C4nQjL1/2lRH/3333dsW4D6NsXLGxZgoo5
	z7A==
X-Google-Smtp-Source: AGHT+IF204pDh3GMb9mprc3RWx877M/hSlys4cJP5Klv0u7H3rkiPLZ3mCZ6j16z/jbKHnJ8e4e+kw==
X-Received: by 2002:a05:600c:3e18:b0:450:cfa7:5ea1 with SMTP id 5b1f17b1804b1-4533caa629amr84883665e9.16.1750072717932;
        Mon, 16 Jun 2025 04:18:37 -0700 (PDT)
Received: from localhost.localdomain ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a36sm10931250f8f.15.2025.06.16.04.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:18:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: hch@lst.de
Cc: olteanv@gmail.com,
	broonie@kernel.org,
	oe-kbuild-all@lists.linux.dev,
	arnd@arndb.de,
	larisa.grigore@nxp.com,
	Frank.li@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Date: Mon, 16 Jun 2025 12:17:49 +0100
Message-Id: <20250616111749.316413-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202506160036.t9VDxF6p-lkp@intel.com>
References: <202506160036.t9VDxF6p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementations are in mapping.c which requires HAS_DMA so stub them
out if not present. This is required for some drivers to pass randconfig
builds.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/dma-mapping.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..766f28a0e11f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -161,6 +161,12 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
+void dma_free_pages(struct device *dev, size_t size, struct page *page,
+		dma_addr_t dma_handle, enum dma_data_direction dir);
+int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct page *page);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -291,6 +297,21 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	return NULL;
+}
+static inline void dma_free_pages(struct device *dev, size_t size,
+		struct page *page, dma_addr_t dma_handle,
+		enum dma_data_direction dir)
+{
+}
+static inline int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+				 size_t size, struct page *page)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_HAS_DMA */
 
 #ifdef CONFIG_IOMMU_DMA
@@ -438,13 +459,6 @@ static inline bool dma_need_unmap(struct device *dev)
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
-struct page *dma_alloc_pages(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
-void dma_free_pages(struct device *dev, size_t size, struct page *page,
-		dma_addr_t dma_handle, enum dma_data_direction dir);
-int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
-		size_t size, struct page *page);
-
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
-- 
2.34.1



Return-Path: <linux-spi+bounces-8597-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D5FADB8E2
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4195E16E461
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07625289814;
	Mon, 16 Jun 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="M8JgK99d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMLLUKOL"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9778288C36;
	Mon, 16 Jun 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098864; cv=none; b=tqPs50LLJVPTasUAkGFtPE4d6bNctHBrkXZnByUsOcmA92b2RIcXeCn9LDm98RHLDBqTdsn+dNcn4YPPN39lZgY5QnBOiFM9RDp5ojh00UvTXbqNMyfb8bT8rkC8TerYpv8Ble+AMDAJJms1QuJId8tTcSb7tNev7WSB4m3DF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098864; c=relaxed/simple;
	bh=KlD+453KlSU9FOwBe+BDpHVkmmltE1oD8QI3Tcq0vxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MKU6ea0jd0O9pEW0bdIVRjpRoqXzfrJnGN0Gs28xNgsLoWGi1PwLZ8ye+FjdlaFT2XPJrD5Y4bf+CmduX3NB2Oq/mSqVV8qomCeIAUaBnwPljOJQGT9MEh6iKC+ev7UCqExiWUh2kDdhWs4FUvS459fTfRFbxCV5d0QkopXoVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=M8JgK99d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMLLUKOL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8059254012F;
	Mon, 16 Jun 2025 14:34:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 14:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750098860;
	 x=1750185260; bh=y8hmEJ8IPHxQr9QAvRRYAO8ndpWyYDotDuUPccTwwbU=; b=
	M8JgK99dtQaZZEduGIDJeOVeN5m3KzZ5Z0Rhk/THsifW3JkqJqhVvfyS4CpVCVl3
	PCsGjFPWusY0URXvQmsZZSUEtWivjt7sEzgI4T7NrFs2l+QFEv3yfdRsnQ7WDfZV
	XDOYNUbYzCOCkWl/EcBJmAox0nsczZQ6r3jkgXJxAtQTFjLk5gKl6TeoecsoC5xq
	wpSAKj6lLUqfb1kEy/LlrTqnRCAe0TkI+JeXXvFHs/RRZiymFiDvloewOXI8ZXeu
	Kj0dKrzqRPoc7HpKqgVyyS/28wzGfFFmdCorbpxGdh4WwKGqrtn8ADCjOgVaMtkQ
	vQp5WW5f7dmZ38xxfpdu5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750098860; x=
	1750185260; bh=y8hmEJ8IPHxQr9QAvRRYAO8ndpWyYDotDuUPccTwwbU=; b=H
	MLLUKOL8dt7Gi2ZERo40kr9Sdfc9W3NucVjLNb34L2wAFK8rbgmbPKoDgeYNd7HU
	Ie29AhaqbHhqK+U5Il55+DwCvBqXxWLwqG/Svj9h+yERHLGiWvCmdqihNOqG9ghU
	PtHbdZpTAdn/tox79NXUUA+CzwRsoR5lXjQbCnjgkyThyIcgwGewcjCF+abLtc/C
	dKKl4uzgzZxHdRBhLdhxOz5abAja+6hiCy5OFaUwdvxf+X3BzfKuKnMK9fDElryB
	H+5U/eayY6Jr36Q3gIn4sWTyf/iqQyZk+68hSQATJ1mCtIuWd5Ug//3dH8ONEhNm
	V/JwBmnrY4wS8BSiLuhuA==
X-ME-Sender: <xms:rGNQaIzmrzoHEOtbGlEQWGn27-XEPLE8afk3BGL4zdkZ1txqTh8_Vg>
    <xme:rGNQaMQNDT8D0c0osQ34K-n8Zs18qgvz0R_BTme4_-y3v9F--YtikGRqms5mJgOJo
    gtmLktCKRKQq_7Tyyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihse
    grrhhmrdgtohhmpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgt
    phhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohgv
    qdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hhtghhsehlshhtrdguvg
X-ME-Proxy: <xmx:rGNQaKVM_TKCwxHqW_hYDc45c4TK0NX6wqQ_Xn1_a5-Epqg0ilAy2Q>
    <xmx:rGNQaGhMtUtCnc2UoSOj4ddvblDERz9q1TPsjsKP77rQ5alfBVXQbg>
    <xmx:rGNQaKC8-vpBCP0sOhulOKXiHc77kaMwv7MJ6MKTNOwjKgHJ2YGkCg>
    <xmx:rGNQaHKsoEa4_hrJxwI5CjNrcCVBUVb-_Dg3QA9pEONHe0MmYuhtBA>
    <xmx:rGNQaDwdL5t9E4qhj7CN_seC2ojskFn3Pfd597TNfCGjp8LAci24b8Oz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F0CD700063; Mon, 16 Jun 2025 14:34:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4808b90e09d8ad4f
Date: Mon, 16 Jun 2025 20:33:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Christoph Hellwig" <hch@lst.de>
Cc: "Mark Brown" <broonie@kernel.org>, "Vladimir Oltean" <olteanv@gmail.com>,
 oe-kbuild-all@lists.linux.dev, "Larisa Grigore" <larisa.grigore@nxp.com>,
 "Frank Li" <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev
Message-Id: <fc18a185-277e-472a-959b-4c5354295691@app.fastmail.com>
In-Reply-To: <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
References: <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
 <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
 <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 16, 2025, at 15:48, Arnd Bergmann wrote:
> On Mon, Jun 16, 2025, at 15:23, James Clark wrote:
>> On 16/06/2025 2:19 pm, Christoph Hellwig wrote:
>
> Maybe we can actually remove CONFIG_NO_DMA/CONFIG_HAS_DMA
> entirely and remove all the checks for CONFIG_HAS_DMA? 
> My guess is that this would only lead to a small code size
> increase on the affected targets, but since they are not
> actually trying to do DMA, and they all have a very limited
> set of drivers they actually use, it won't break existing
> code.

I tried removing the stubs on sh/j2 allmodconfig and found this:

ERROR: modpost: "dma_unmap_page_attrs" [drivers/bus/mhi/host/mhi.ko] undefined!
ERROR: modpost: "dma_map_page_attrs" [drivers/bus/mhi/host/mhi.ko] undefined!
ERROR: modpost: "dma_alloc_attrs" [drivers/bus/mhi/host/mhi.ko] undefined!
ERROR: modpost: "dma_free_attrs" [drivers/bus/mhi/host/mhi.ko] undefined!
ERROR: modpost: "dma_unmap_page_attrs" [drivers/soc/mediatek/mtk-cmdq-helper.ko] undefined!
ERROR: modpost: "dma_map_page_attrs" [drivers/soc/mediatek/mtk-cmdq-helper.ko] undefined!
ERROR: modpost: "dma_unmap_page_attrs" [drivers/soc/qcom/qcom-geni-se.ko] undefined!
ERROR: modpost: "dma_map_page_attrs" [drivers/soc/qcom/qcom-geni-se.ko] undefined!
ERROR: modpost: "dma_set_coherent_mask" [drivers/soc/ti/pruss.ko] undefined!
ERROR: modpost: "dma_unmap_page_attrs" [drivers/virtio/virtio_ring.ko] undefined!
WARNING: modpost: suppressed 733 unresolved symbol warnings because there were too many)

Enabling HAS_DMA unconditionally all all the platforms builds:

--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -64,7 +64,6 @@ config SUPERH
        select LOCK_MM_AND_FIND_VMA
        select MODULES_USE_ELF_RELA
        select NEED_SG_DMA_LENGTH
-       select NO_DMA if !MMU && !DMA_COHERENT
        select NO_GENERIC_PCI_IOPORT_MAP if PCI
        select OLD_SIGACTION
        select OLD_SIGSUSPEND
@@ -134,7 +133,7 @@ config SWAP_IO_SPACE
        bool
 
 config DMA_COHERENT
-       bool
+       def_bool !MMU
 
 config DMA_NONCOHERENT
        def_bool !NO_DMA && !DMA_COHERENT
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -22,7 +22,6 @@ config UML
        select HAVE_DEBUG_KMEMLEAK
        select HAVE_DEBUG_BUGVERBOSE
        select HAVE_PAGE_SIZE_4KB
-       select NO_DMA if !UML_DMA_EMULATION
        select OF_EARLY_FLATTREE if OF
        select GENERIC_IRQ_SHOW
        select GENERIC_CPU_DEVICES
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -37,7 +37,6 @@ config M68K
        select MMU_GATHER_NO_RANGE if MMU
        select MODULES_USE_ELF_REL
        select MODULES_USE_ELF_RELA
-       select NO_DMA if !MMU && !COLDFIRE
        select OLD_SIGACTION
        select OLD_SIGSUSPEND3
        select UACCESS_MEMCPY if !MMU
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index c9a7e602d8a4..a1123e2fecdf 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -38,7 +38,6 @@ config SUN3
        depends on MMU
        select HAVE_ARCH_PFN_VALID
        select LEGACY_TIMER_TICK
-       select NO_DMA
        select M68020
        help
          This option enables support for the Sun 3 series of workstations
@@ -558,4 +557,4 @@ config COLDFIRE_COHERENT_DMA
 config M68K_NONCOHERENT_DMA
        bool
        default y
-       depends on HAS_DMA && !COLDFIRE_COHERENT_DMA
+       depends on HAS_DMA && !COLDFIRE_COHERENT_DMA && !SUN3
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <asm/cacheflush.h>
 
-#ifndef CONFIG_COLDFIRE
+#if !defined(CONFIG_COLDFIRE) && !defined(CONFIG_SUN3)
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
        cache_push(page_to_phys(page), size);


Return-Path: <linux-spi+bounces-3895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5259346E3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A651F23659
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3B43AAB;
	Thu, 18 Jul 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW43qU+L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30E3FBB3;
	Thu, 18 Jul 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274469; cv=none; b=FEOO6o6LBF3O+lzG86vEEyQAa/BMeCZ5yQLwpmLvfgDwGpE55DI1qLz+O9yoOQRoNQHy2qa3toousBgmVr1OD0u3wQEtxXZmdMXFfZHo6uo4S9oRIqFnMHwAWH+amGiBlcuF/Ns3BTcdsHrAWj6JtE41IGt2dnIQxrX389c+qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274469; c=relaxed/simple;
	bh=9YsmCa6ahFQU4Baxm5f/jlWl9GbUPNUOqqm4AInViWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/eT7Ewn5GocHxjcG6XbKlnX0+au0WbuORiqh/x09KJd8XhQv3LJY31PAYYpijc2miYnPA3saIRCWCQkGhAhM6sH2leybwLiBvAeUQXi4yXsPVr5pFogGTYjHRYXJwBm/cYzN3Vv/cjyEli/54RJHfcPrlOx1BhjaWm6Hp00dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW43qU+L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b05260c39so269670b3a.0;
        Wed, 17 Jul 2024 20:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274467; x=1721879267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK8A6fJKM9NFmReipLfzB3Jrm/Kc3i4yYA6+cJCoL4w=;
        b=CW43qU+LJ72zgaYTjJhz4PhxM7zSqBtOAiI2VGMh7slLzCUYLvrL49crfncOcGuR4f
         1qg28y3OpcLITPDKewZE4VBMdM8dpqBDuDDhiNS4SFkFSJ5ctLqw6Muyp5eKZFe+b0WL
         O9xTkBpZdC60LQPa6RHlEyt+IDibAESe777TexeKY+KnB/pL4z6cVTqQ24mPdi/2tdJc
         XKI0l+WYvCwXgSnEqspMhySNw9gAn1jwN+GdZvV4ckDKEUlX+AV3ya7FjtYQgd7vszkj
         sq5w01BrHRzMAs6ulO9YoTIiuS4Jkew9GdJkXKOfnThJHwi2HwMR0cEu9G83kjCuv3Fk
         W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274467; x=1721879267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK8A6fJKM9NFmReipLfzB3Jrm/Kc3i4yYA6+cJCoL4w=;
        b=ZemGPQfn4nysvTHv0xWvM/BsvO2T/8FzbkHZaJbONiF4BD1Eqd9xYnOaKlvi4cqawM
         Qzkn2t7AA/kDz2IonsEIdmEz2chu1lChWPq9nvvDjJr0iyvNxamw/rcsi3NNsCJw4zFQ
         khhM1wPKuNzMU41ytwlhnv3JSfnFG9Kyeeyq5BomMDRPqNNG3pW+GXkaHRiQhTQwcj/W
         6znItrMe4kFwmYkP9cMcG/hM8zVtP9oS7jdhXIfUN4WARRXdHn2mhTHwNtId2p00CR/I
         Kul1ixo2WC7RiQVHzbeYuX/+NbZgMO61eEMlbzHnbaZefVV6ivY4lp0JQpegtj9FR8jh
         xxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKS+yxA7EgX8k6zf4tcH0kbJp7ztNWonex1HHI6wbEawG/PxYapx2vT5A83eVulu5ujnHHeI4cDiUR+T7TRvEXrFRVA/2rct+RxoSOMbnm7Vd30xUtmm/a/jIEH2z3qw5WwbCbfnvb
X-Gm-Message-State: AOJu0Yz/b1O69ZLbo1vyPEDnNFST4vSfVrm9UCfL1osCnircZl/BtPYm
	Wx/H5gshxJJ8enF68NpayCW+P8BfzGdUXgwEkzvlRcMeWnagWRdg
X-Google-Smtp-Source: AGHT+IHcTZWJKp3I6YvIAQebjFHORQTS8t4I/7NrZuEmULEE/tJlq9btyx9tt8pVYcgcxlGPtM4xQg==
X-Received: by 2002:a05:6a20:db0c:b0:1be:c2f7:275 with SMTP id adf61e73a8af0-1c3fdd5afffmr3572006637.50.1721274467440;
        Wed, 17 Jul 2024 20:47:47 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc62e57d6csm1770455ad.43.2024.07.17.20.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:47 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 53C0F800D3;
	Thu, 18 Jul 2024 11:56:58 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: [PATCH v9 4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
Date: Thu, 18 Jul 2024 11:46:12 +0800
Message-Id: <20240718034614.484018-5-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Parse BFPT in order to retrieve the byte order in 8D-8D-8D mode.

This info flag will be used as a basis to determine whether
there is byte swapping of data for SPI NOR flash in octal
DTR mode.

The controller driver will check whether byte swapping is supported
to determin whether the corresponding operation are supported, thus
avoiding the generation of unexpected data order.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 drivers/mtd/spi-nor/sfdp.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 5b1117265bd2..21727f9a4ac6 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -671,6 +671,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EOPNOTSUPP;
 	}
 
+	/* Byte order in 8D-8D-8D mode */
+	if (bfpt.dwords[SFDP_DWORD(18)] & BFPT_DWORD18_BYTE_ORDER_SWAPPED)
+		nor->flags |= SNOR_F_SWAP16;
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index da0fe5aa9bb0..d90cbd7331f7 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -130,6 +130,7 @@ struct sfdp_bfpt {
 #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
 #define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
 #define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31)	/* Byte sawp of 16-bit in 8D-8D-8D mode */
 
 struct sfdp_parameter_header {
 	u8		id_lsb;
-- 
2.25.1



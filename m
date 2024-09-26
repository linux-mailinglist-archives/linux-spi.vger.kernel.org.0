Return-Path: <linux-spi+bounces-5000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4198758E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AA3B27A4D
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7266154439;
	Thu, 26 Sep 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvbdpTKC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF731531ED;
	Thu, 26 Sep 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360716; cv=none; b=tsJ9PGsYI0Ax+M9VwYtY3ywDuSFDSHRn4MXSI9b8bC32TjmYIMFR+W3yEOcpDXoFUcz1E2S02TIFBM5OT/Ym3CoAKqVCH5tTXPfzsrhfXyIo8KuyQjas3jmEjz9veTR+jHLrf9wraaQgXleK91PU2tHDtuchPIYFUHUSUmz/bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360716; c=relaxed/simple;
	bh=YfVErJFWvQAjc+YAokwbZxUEeqlwW35HO2SBJoUvN7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfUzeBGpeCyotQgJ35llfpUxRYguqMnsEkIC5mUZYKB2bn45LTc6lfbvL6EJ+PE71vNBnJ2iwiYpqv0+bMQCSu7bdqmJEDR0EcJBYniKoOXFym04QOkrnN+oc+X64+WhH+Yk8SAbBeui2OaSB9JOvfHd32FJ8dz37DaGBZ8PjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvbdpTKC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so832523a12.3;
        Thu, 26 Sep 2024 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360715; x=1727965515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGxTXo990ti5lAyVI8ZehxzUFXPwz6MqQx7qAzjMfhw=;
        b=TvbdpTKCrcPDXzVhaxTAvTmVjsQZWtx7+F7wKBLdz1BMCXMy6H/pyWDKVACOlP/IKD
         7uO95OJPDIT1H3C8jEjQKD7M6IAeO0VBg9cr6ZIxRyorP6oDUzeNa4XZTzVx4xMfBRCL
         jxz5HaqbP48TIHRgo0AB5JDVcyGXInbVOVvFsZn8t8rzzrYNqAZBRgvPOZdNjBX+fu+T
         EBK7Kp//REjR97mIuiQPpTJBWWPgW5LRi0KHGcmc9M+007YPLFVKT66kgI9PkU16RgIU
         n/Gww0xu7kqiZ8l9aGQEInVeu18Jo65+OxrpegphxEjF9WwxY8GLWOEnHwkIiV8Ie4Ks
         TIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360715; x=1727965515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGxTXo990ti5lAyVI8ZehxzUFXPwz6MqQx7qAzjMfhw=;
        b=m37TQeuCa9LiPMke2bKzi1KWP0vPrxcH0k9HRVBa6GK2gofOLjsJl8PsEBYAl8NpGJ
         qzXGoacb5EdDN38EHIMrzu8+vSESOMH5bkjAlTVP4ppfWj9TCVZUcPjETx68N68QljTv
         imrGmnqsdcGoojCt/ul/+sUglOuWRytI6QAW/eXA0I8vOBWFihw3w2qA9zBCwk53sfk5
         juvSF2w4qMLdXxqlQw4pZqKYxejW0U7YN1WVw8aVRaWxqSIrzrDh8yxCZpPHgM90vZJb
         zUv5sbbtnEJBjby9vOCDZFR/g/7uYZ/qPb/1fOrZM2Rvbg/RxvTtat5SiZAoN2Ake35U
         z4TA==
X-Forwarded-Encrypted: i=1; AJvYcCWI/DJD2HUFwRqAzqSB+LzRnmEMlRQW8xVJr53u3Hq7yZkMsdyusuUzFrFEQ9zeLg0Vj0b/5HCmyE2Au1w=@vger.kernel.org, AJvYcCXAAvMgCcQyks/iH25kh5EI9F3XCH2oXXSeem1ID3VweMlcowk0ODYsrDYIdCLY4SIcWliwDyNKNJAJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06hO4QFQHzqP37efjbWtC4mbqIi9TGjTtDY7LCV+f0dVNaTkS
	rNSJDnFKWuTl0cf/9AlonY5XKO2MOH7bQcn4Y2y+DQ9ojEB1IhFp
X-Google-Smtp-Source: AGHT+IGJwQwDCJBexl9tEe801nzR8/z6arvXHTxHSnx3fsr9XAE3/M0h4vZLwCeKudo7PtJWcCWLpw==
X-Received: by 2002:a05:6a21:78e:b0:1d2:e1cc:649c with SMTP id adf61e73a8af0-1d4d4aaf073mr8517160637.15.1727360714640;
        Thu, 26 Sep 2024 07:25:14 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc985c99sm4374462b3a.180.2024.09.26.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:14 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 0432080580;
	Thu, 26 Sep 2024 22:33:02 +0800 (CST)
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
Subject: [PATCH v10 3/6] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
Date: Thu, 26 Sep 2024 22:19:53 +0800
Message-Id: <20240926141956.2386374-4-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
The byte order of 16-bit words is swapped when read or written in 8D-8D-8D
mode compared to STR modes. Allow operations to specify the byte order in
DTR mode, so that controllers can swap the bytes back at run-time to
address the flash's endianness requirements, if they are capable. If the
controller is not capable of swapping the bytes, the protocol is downgrade
via spi_nor_spimem_adjust_hwcaps(). When available, the swapping of the
bytes is always done regardless if it's a data or register access, so that
it comply with the JESD216 requirements: "Byte order of 16-bit words is
swapped when read in 8D-8D-8D mode compared to 1-1-1".

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 028514c6996f..31f57b17023f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -113,6 +113,10 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
 		op->cmd.nbytes = 2;
 	}
+
+	/* SWAP16 is only applicable when Octal DTR mode */
+	if (proto == SNOR_PROTO_8_8_8_DTR && nor->flags & SNOR_F_SWAP16)
+		op->data.swap16 = true;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..baf6c4b5912b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -140,6 +140,7 @@ enum spi_nor_option_flags {
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
+	SNOR_F_SWAP16		= BIT(17),
 };
 
 struct spi_nor_read_command {
-- 
2.25.1



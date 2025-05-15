Return-Path: <linux-spi+bounces-8143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97330AB8F91
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FC31BA1634
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D129B765;
	Thu, 15 May 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqukJCwA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93628642D;
	Thu, 15 May 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335512; cv=none; b=MCfO5awCNF4Sb3BIgHVXB8dyk4MtoIkEceqcB0sUFg/yMUxMSSht8o3myL7DEANHGbyWvFzcWNY2UbxdKxifPqDS9IKvTLvo1ixL1NGZm/cZfbi8x32ZKTpilFdjmkL0EEtJ2kJlz0um2E1uQQj3Xr9rXREOgfcpRGOPbyRyp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335512; c=relaxed/simple;
	bh=R9+E/jvRIAgbErtUCsQF7o2wS8bqNaKox9ed/uj0mR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHZjpU5ZPLHhoykqNRpi6MMCD6bZSWJ9Q0tEB7pphZNYYHIsvsRuie0Tjd6Qe+rfZoMZ7ptKHna18pv6J/c4ZxrfaPuUWMTFJD8Ph5EUmqdZDQ/jp691MqMHIxebtfW+8/JXt/z55NE/j/4wE7V9Hl26G4zoTYqdVBwaApbAwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqukJCwA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso10422705e9.0;
        Thu, 15 May 2025 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335508; x=1747940308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uyejmtz0c+qWQ5LaiwciCgzl0ypKnF8Po4gKuJr/+k=;
        b=aqukJCwAtkf9mpyrqE9NT82ARLqmmRP/XfUrI4USwx1/QbOGwgT0CmKXhO+LD76Cb+
         46DSSX7igFPq7hx4K9MUMS/rNXBHmKKpQHmEVrkyKZ2wGHFWErK5Qf/Uc6oJ4othMhw6
         6eUwGWGPAX0yAW62j2swPPDEGdwjoY9fww1EPtpM6zxuC4c228HMKiahdDLY8Qjkl7TL
         pAcxGsGkQF14VLdIDv7JMHlR7Xwp+V6EAknPImthBZf4xXVY+KcIPg0Bgls1V6JoLZwq
         yETFY/qiDkOQIbQDmL+o2PcXwZV3wKwbI2FQx3CNtII7Sd3JjXB0EKNHziI0wWltyRuA
         deoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335508; x=1747940308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uyejmtz0c+qWQ5LaiwciCgzl0ypKnF8Po4gKuJr/+k=;
        b=TcC1SWB8mQTry67aQ6x+RO+L5X9wmAzGx+FY0ns2SHFL0CPTtXoSPhyjQjQNEd/pEz
         2Is00qv+Hj4miyUqBoTg4amLE3LDKpndjRAtl7k4j8Sk8rzSts1nm+PiYM80ZD6lZdpD
         jNxW8mQTBVmX53oWtUYoMg9Cu17r1J4sXp27MXyFg7b5DISRKdqMKuRYSae2ZqNKN+5n
         /FszLtC/S+JGcAGkP5fT0CRMm6kt8JT2EgSImAwGN+AfiqyRohemy+52Eu90nE5JTGJf
         ZgHCmkvxSzr5QxHVnDLae3diqGZKG4Hk8r8BxZIFDZ8o8BlaNIcVLlkN4G4Mdg43XXXW
         QkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwAjZD5OAyRTef4QcLldN6+2hSteQ/HfxcRPK5kWa8lDOfCwqTByPiJcxGWGyo6/iXqJQg/H64PQk67B/@vger.kernel.org, AJvYcCVuXrZLk68uDlGb1F/DcPxAXxWVm7J6BGDhemJAFaexoWi1Wq054YYjRm5XMTkDcus9Jl/qpDE5BgSYOh2B@vger.kernel.org, AJvYcCW4HgxQWVV0sB+iyGvO/9kkY2k3xkk4ZCL/BnS8Tqwqq0ONW4AHLRd7gXEvrr4UR+8nOQxz7mrFufPE@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJYq7jn0oJkWN/JJyqC/3kBImiJ1HlPYtI/bxdbhPNasG0244
	nGt2kNm9LTWK93mjeUlIfgmGQF3XrrsXSMEMIu3zpi/CgdcUeXifsI3fAstUeQ==
X-Gm-Gg: ASbGncuS/mLl1UUUV376Dlgaj6B2yRR1DJlK/j6PDe3U0UNog35vsk7R3r5zrPSinTD
	qbRhjnf4CDupqB/8ieces9/rSndwHCdGztwExHhLqx6bc+WzYzyDyohAl49L2Y/dRwxs8j60Aa2
	nI7y5B3SXQUbF9YAYIFkd+Qi2KkEn/3DbtSfZZtslD3J1QsrBTSxnARrscMrvQThwYXDxUySmL1
	YQn/FszqzUl5g+1f3RuUm+9QrnA2AubsacTtTBaNAvKLJK0kqVpHEyXCw999RWhmPW4Pug11K6c
	ASGQ1D+OZ5q3SxaqD6jvQcif7iWI6+nCYHm/UjWP1TiWzM9tTOMhLImrz+T+oMhMP0ZG7QY+2BO
	IsN8E
X-Google-Smtp-Source: AGHT+IHaF5/8q+je2iW1pwj88K62M744soT9y5wHNJ4gvYxacC9IaeaSHOljAqzLiWm7Ak+nx/AzHA==
X-Received: by 2002:a05:6000:1446:b0:3a1:fe77:9e0b with SMTP id ffacd0b85a97d-3a35c843f52mr1022650f8f.16.1747335508447;
        Thu, 15 May 2025 11:58:28 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a857sm335778f8f.32.2025.05.15.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:58:28 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 15 May 2025 20:58:06 +0200
Subject: [PATCH 2/2] spi: spi-qpic-snand: extend FIELD_PREP() macro usage
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-qpic-snand-use-bitmasks-v1-2-11729aeae73b@gmail.com>
References: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
In-Reply-To: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Large part of the code uses the FIELD_PREP() macro already to construct
values to be written to hardware registers. Change the code to use also
the macro for more registers of which the corresponding bitmasks are
defined already.

This makes the code more readable. It also syncs the affected
codes with their counterparts in the 'qcom_nandc' driver, so it
makes it easier to spot the differences between the two
implementations.

No functional changes intended.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index bc45b834fadc5456eda1fe778e5ca8b16177465e..ad01bb456a88b54f0ffc801dd14eb3fa2708ec2e 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -130,9 +130,9 @@ static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
 					int is_last_read_loc)
 {
 	__le32 locreg_val;
-	u32 val = (((cw_offset) << READ_LOCATION_OFFSET) |
-		  ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
-		  << READ_LOCATION_LAST));
+	u32 val = FIELD_PREP(READ_LOCATION_OFFSET_MASK, cw_offset) |
+		  FIELD_PREP(READ_LOCATION_SIZE_MASK, read_size) |
+		  FIELD_PREP(READ_LOCATION_LAST_MASK, is_last_read_loc);
 
 	locreg_val = cpu_to_le32(val);
 
@@ -151,9 +151,9 @@ static void qcom_spi_set_read_loc_last(struct qcom_nand_controller *snandc,
 				       int is_last_read_loc)
 {
 	__le32 locreg_val;
-	u32 val = (((cw_offset) << READ_LOCATION_OFFSET) |
-		  ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
-		  << READ_LOCATION_LAST));
+	u32 val = FIELD_PREP(READ_LOCATION_OFFSET_MASK, cw_offset) |
+		  FIELD_PREP(READ_LOCATION_SIZE_MASK, read_size) |
+		  FIELD_PREP(READ_LOCATION_LAST_MASK, is_last_read_loc);
 
 	locreg_val = cpu_to_le32(val);
 
@@ -352,7 +352,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 			       FIELD_PREP(ECC_MODE_MASK, 0) |
 			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
 
-	ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
+	ecc_cfg->ecc_buf_cfg = FIELD_PREP(NUM_STEPS_MASK, 0x203);
 	ecc_cfg->clrflashstatus = FS_READY_BSY_N;
 	ecc_cfg->clrreadstatus = 0xc0;
 

-- 
2.49.0



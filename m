Return-Path: <linux-spi+bounces-7776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944BA9E95A
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1322188AD2B
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA01DF754;
	Mon, 28 Apr 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBiZs0de"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA81E1A3B;
	Mon, 28 Apr 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825464; cv=none; b=ZSYrbfKx3wuyCxijF9OTab8Vqb0H3ybjLy8YRo9HtaMdE03PLWqMS5PzBnbXVg9FPsJkt1Av+NlIN/TylX54XPMl6Q3R7TxpDimOP7J31hmALKLehi/FXvtAxBAchbL7vws4V9MuUxyCqWe3LLqa1ftFcY+MawwcVG/NIgsIHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825464; c=relaxed/simple;
	bh=vzZK1rbO1opxOWmxS61Zn7nB8JQz8FzObuONPZDdgg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lSxOzoGcBocjYlsn5bsH/HuLN2tTrKdo2fqxBOEynlr/EskCJije/3pJYm6f3bYJPo+I+emB+dDH6jChdp3K0Mn5nzOXDnRgJVXNSomwPssmq1XeU0DofKikl9YaK1U080dJjf42K9flvZeGX1EL0x9+sE9f2+nsU/svUURyFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBiZs0de; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so6773931a12.3;
        Mon, 28 Apr 2025 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745825461; x=1746430261; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TbMRqWlbuD8Jk0c4g1z1Zqott/oeTMW5o8nGkLNa1I=;
        b=NBiZs0deWuhHUQObu62RbbpUcptjc171TEIAgtkInAUqH5lpT9n5SmETCigT5Bc5Nm
         lv4WmZenJ5vxuTQ6YBuckcdHaUGtDh7XlWYVeA8xYPMcC23/V9FG9o00hH2X1f1gr4au
         +Gsj6PLxqeO4Dh0+/kvZl3TbGwymnBFUpW2jRNh0VRHAYZYIzpeheAvGaY9KfzLOaGJY
         QLPoOMM0gM8EQopXoDf9/tiElIu4bc1WdnTCBocfEXYwS0gW6ybF9rHD0mjzd52nvUhh
         YhpKtzvsChgMIzXhbIcvmSt9kmcPr6UpwvLlPQXFvGImOgY/nsx7Qe0HDgVuBUX++eAu
         VAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745825461; x=1746430261;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TbMRqWlbuD8Jk0c4g1z1Zqott/oeTMW5o8nGkLNa1I=;
        b=AZYszT1tKIydGuZR7fQyjjxnddRtbhZTbDpA5NKlFoN8XgCAMNlkRsTKHG/ccJriCm
         9arkFgBSpH2rkDWS0v6Zhp9dl2SClixBS0LEe0XqXYXhjC6frPTpx5TVE2LCTMXFoKbU
         AHDwCUrTHC3habxRq8uwNdD5n532nHpP+FUSl4LmyF2UrM43h/YTujb0/X59SjejUbY7
         Q1jVrcmJXindodI/0SiHRi5g9MnJmfBg45o0gICkK8PcXVpZvKq+bJ3TG686o0sLTq2V
         T38A8lmZ/D5AATIPoO/1IdKJDBWzoVcuJJeLrRf6tQtEqHKPQnYA6v1OZ46aLKDeEGy8
         8Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCU720nWd4lcHXfSKtMJa1RpMuYchMxnZwhzz3foW7VPN4H8tyEaLfaGJd4AgvzvdvUGT3ibgl4X/gEjsSc9@vger.kernel.org, AJvYcCUbb/UsUAZqPu3PrXJmWNhYvlYe7XmTfRNxIK3KSyPTnbsttVmhvK7T0gO4zy1nMFs+iJzy9PpSkVRB7z1v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FGbHAlHgaVsbsBHv1pXvFvB0mZP1D7FtM+mMO05IMbUth/rB
	M4G5TlWs/U3t4lrtuZaRuNFSIy2GmwR+8PrlEmc40jVaP67ytO2R
X-Gm-Gg: ASbGncs/OjObph0VeqdlLz2gNmCRtSTvlaaK9dsc4soq+dny0glWuNbhdK0CaDNiw3n
	ww3C1NPtsXonz5TM0ae0oIylkjhNGZKS2r7tdwIcYfgWfCee9r/hCjAE12UpoL83LvkPDczjP+b
	CV2B7pCK7aAa1KCUwR0EmbEXYqGH1SXccm2gzDRz7K8OpNWpZQQILDBSDRPQyKeFKyjSfNnXaR2
	SQmO0JA7mOiwSVcZA8S7fE+Ein38uyidOc9Z5lDg4pIr11/wC4a9Xd//rJtKQVf6xiURyfykgmt
	JIqj62QNca1CDev/dCWZqK3buFa3gbn7CYjFrUNslnTlU8dJ/Elw5K8K7q6XLnWK5mETEJiHS27
	huGvjGQ==
X-Google-Smtp-Source: AGHT+IECkAD0RhKI699skwaAuKgZAu1ETRTnosTVuSJZ0BYUVLz8u5qyGONHw+yQVtW+1wfmwORi6g==
X-Received: by 2002:a50:858d:0:b0:5f8:215d:769f with SMTP id 4fb4d7f45d1cf-5f8215d76aamr95590a12.2.1745825460645;
        Mon, 28 Apr 2025 00:31:00 -0700 (PDT)
Received: from [192.168.20.124] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354638bsm5371527a12.63.2025.04.28.00.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:31:00 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 28 Apr 2025 09:30:55 +0200
Subject: [PATCH] spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register
 handling
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK4uD2gC/x2MywqEMAwAf0VyNlDja9lfEQ81iRpYqtuCCOK/W
 zzOwMwFSaNpgm9xQdTDkm0hQ1UWwKsPi6JJZiBHrWvog//dGFPwQTCql9/GhLOdODGL63mmTmr
 I9R416/c8jPf9AIu5D79pAAAA
X-Change-ID: 20250428-qpic-snand-readloc2-fix-bccd07cf26d3
To: Mark Brown <broonie@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The precomputed value for the NAND_READ_LOCATION_2 register should be
stored in 'snandc->regs->read_location2'.

Fix the qcom_spi_set_read_loc_first() function accordingly.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index ae32c452d0bcf852b69b76e595f3588ea7e1a670..94948c8781e83f30650e5fbac56897daf5eb3c2c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -142,7 +142,7 @@ static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
 	else if (reg == NAND_READ_LOCATION_1)
 		snandc->regs->read_location1 = locreg_val;
 	else if (reg == NAND_READ_LOCATION_2)
-		snandc->regs->read_location1 = locreg_val;
+		snandc->regs->read_location2 = locreg_val;
 	else if (reg == NAND_READ_LOCATION_3)
 		snandc->regs->read_location3 = locreg_val;
 }

---
base-commit: 15cfe55ec58ace931a73e19e5367598734ceb074
change-id: 20250428-qpic-snand-readloc2-fix-bccd07cf26d3

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



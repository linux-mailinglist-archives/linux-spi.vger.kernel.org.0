Return-Path: <linux-spi+bounces-7726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1DA99881
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4943BC5FF
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5E292922;
	Wed, 23 Apr 2025 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRA/zqPl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D519D081;
	Wed, 23 Apr 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436739; cv=none; b=gwcl5j+wWD/Zbsem7VRXA74WvtA+GoH8v/4/wsKANFin6Ve1UIyodm3KyjndvjORIUg/joAQ1+cgyAIcjKk9crZZnsaThsYF8tPhPSucLzq7FRem5Zsyb6uvBrhHFm2pDhmIJD8m6ZwtJknVAnPqxQqxqqG5HSqoGiNwausM1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436739; c=relaxed/simple;
	bh=irO6xo2Eosr73XLmxjEzRhfCbFdEZXbpH0Y4ZyRw5ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qoor57mDRfT8BlBGXRB2BmCu5GCAyZI5KG5j7qnFZzDbfR5YKZNnzDnfpUn8jHS4S1zSTI+n+3uIOYJ88bzY6Gf01qtRJTRGF9+olhgIB2rsCQhq0CpNU3sr7A5fgD0Rx9HLDnYwoO3B9DOsM9TRvpBd6tWbm7CQzLz46u8khBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRA/zqPl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ace333d5f7bso41876166b.3;
        Wed, 23 Apr 2025 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745436736; x=1746041536; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQn3DRL4RP829nvfnG1w+3VmbMB4w74+ATdSejfmqSM=;
        b=KRA/zqPlGK0N4joNE8Io1eOwWjCVOZjhlXoe9M/ukCVUZsf00+P8fz8QJwLigfbAHF
         XZx6RFqSFOmWdFIs8q7h/9DRQcg1cLqfPEAm0MzRhbrbuIfgx/d0avTAsS69Pv7eOK/X
         p0nVccDGOAF5AufyBGqbMpCM3QrNzacfi9MPhmERkNzlaMYb9QJPj0CGwF2IVDAv0CBp
         LxuT/ZYESdVbYbsk8W/eK50XBYXNaW98Ds8QevBaWcNkk2P3Mlza4TcToXTks4KHXQLe
         Js4wHTI4Oy1MkYeLI5IPCixONYX3WJYkcSe8xIjg8nCakQRcS1Zpqz2Ai0Le8C5bL3sc
         nK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436736; x=1746041536;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQn3DRL4RP829nvfnG1w+3VmbMB4w74+ATdSejfmqSM=;
        b=PP3d+rAUXqeTA4BAO4ZkKQ06WhNXy/hewJXPnBubeiqMEsFYrKceLaaTR7r5JOg/+d
         eCf+kyWFKIQecu4VoSzbMOcXHXUzaSHriCiNoo71nR3zlshdEdx9Q2/NiiQ79Y9nvjqN
         unT3nwZllONNBQ8IvipH8XHqRQhQxNdppkcCW4IC6wWkifKQYrikMby5vOt2ldBojZdy
         R/PMsJEutzDygylG61E/t1bCIVw4L9n+Qj5lkrXobly/AvmCZxGiSoW0PRffUN1Rplro
         4HiOk15WaQpX4t5TjOwCRVlwF9ysFiix5lZa7KBbJdALBlBC+g1nz5S3HX7j2Z13LhHC
         1ymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdWj8d6FZaZlfFnl0Lmw0mDNe8VTnHPo9iyLRS8DsU2wBinV/UTI6OnohJ0QqnRiH+XY4OqpKHFJrhAaau@vger.kernel.org, AJvYcCW3xlUurcQZZD/8lA+9vdj3df8ajlBgqQVwCmAGLLlgIsAE/ndDuB+wxX8cgxyt8VV7ieHlmEs+BrVdEdMu@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg0MDoKvNBz4Mc3VSpwRcxNSsI1LsdbEZZEGFQiqHPRPGglHy
	QSIEjXUxKF8zz8HlbotYCm1IYu31Z8P7w38HkdrFyO+oPMZzThZt8tK2wQ==
X-Gm-Gg: ASbGncuYv84hXq68LpiDYRZX6uwDQC0PkUQ006lVoIiK/To0sMK7j/39RsKieqNNtm4
	s51zqqXGgu99+dIfFBWLwxuZ5brS7zA1kBV2sKLLmNi2c7FkaYI1rWBkKwJZpvvUHbB6fiRC5fu
	Y93gR4Upm7Ddih4vBozRSK9OPtKg4JGq1Kue2cEi0MD0La1S+hUpyHAPV2h2LGM/38JkEEony/X
	rzVqX7tDpgETntsHx/NIzAar2jwE1C1Gc2m4DC0oxuTnokYRcPWwzB1Nd8wmy5kqurJOZM/kECN
	EEPVffmdf6kbwuDJkV5JuVBp15//Q67W1knh9A8BzD9npSS7Qm+oY08bFbmMU8tNQ6aIgA==
X-Google-Smtp-Source: AGHT+IHT18d794Ji9hf7W0HV6iwefNzZYHGo0nf5c+s7xFlM/chCUnue7PpKhxE3F4tUdGZK30ZijQ==
X-Received: by 2002:a17:907:6eab:b0:ac7:9712:d11a with SMTP id a640c23a62f3a-ace572bd80bmr5209766b.32.1745436735928;
        Wed, 23 Apr 2025 12:32:15 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acb6ef49c23sm828863366b.153.2025.04.23.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:32:15 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 23 Apr 2025 21:31:57 +0200
Subject: [PATCH] spi: spi-qpic-snand: propagate errors from
 qcom_spi_block_erase()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
X-B4-Tracking: v=1; b=H4sIACxACWgC/x3MMQqAMAxA0atIZgO2KKhXEYdYo2ZpayoiFO9uc
 fnwlp8hsQonGKsMyrckCb7A1BW4g/zOKGsx2MZ2TWstnlEcJk9+xagh0k4XI6sGxcENXW8MLSV
 QBlF5k+efT/P7fgAiB5JsAAAA
X-Change-ID: 20250422-qpic-snand-propagate-error-9c95811ab811
To: Mark Brown <broonie@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_spi_block_erase() function returns with error in case of
failure. Change the qcom_spi_send_cmdaddr() function to propagate
these errors to the callers instead of returning with success.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 17eb67e19132612c4c1a84848fa6f7432b1130a8..ae32c452d0bcf852b69b76e595f3588ea7e1a670 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1307,8 +1307,7 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 		snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg << 16);
 		snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
 		snandc->qspi->cmd = cpu_to_le32(cmd);
-		qcom_spi_block_erase(snandc);
-		return 0;
+		return qcom_spi_block_erase(snandc);
 	default:
 		break;
 	}

---
base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
change-id: 20250422-qpic-snand-propagate-error-9c95811ab811

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



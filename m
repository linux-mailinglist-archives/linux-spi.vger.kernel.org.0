Return-Path: <linux-spi+bounces-8309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA3AC4CBF
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 13:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F323AAE1D
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659323E35E;
	Tue, 27 May 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ5Spbjo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049824BBFC;
	Tue, 27 May 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748344121; cv=none; b=sYmQyCt48CEj5oPvJiLCeU9RMrwY+yrNxDTli/j8Z0FPBctqijGw7Z2S1YFka6CG0kDrQczcHBeuT+QRdJVywZqUglYUnVYpjA2gny/WwTQEU6fwohnhPMBdXk0/p2nP7NSgtLEZLsQ7bEB+Rel739NcdNiPyUC3L0nv6ctJaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748344121; c=relaxed/simple;
	bh=lOqrk1vJHm4pg/GFV/rSBJzV0BYL5W2LQEo9bDARkj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aitSVMFAlRNa0hVlLTsWOxIDxSVxBHE2xszJwTBNuMNGSirDXkm9KyxhCgn2b3r9fswXurvqdfMSn+Oa+wzcv2MfT39R4b0IlMOdgNaQHQ6F/9xq+3EcXKFqpfKGCRfB6gbMx7BBy3TWqJjG1lQbC5y416DSnNceYMwWuyrZef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ5Spbjo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad564b7aea9so844751966b.1;
        Tue, 27 May 2025 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748344118; x=1748948918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrzlUqZN0a5R+G7GF9tUab03ZGWFooFwFU0L4xjwtxM=;
        b=OZ5SpbjouIm1pZKN3E2eah8Df8zTVyVn+zNNHyO4JL/9FvmfPJJ8SRnidFxa4Np10x
         R0flgD5fBbBFMvdD59Hz9XN6zQKpChHP8bJC8X5m9vSlteccRfMfC3SN14rjkdTwmsPx
         qy7zrOEJUGORrEHwSVR4o2Lo8TzWJlPnQJsPkpk2rgsmpn6Z88aKLvmL8fkDDorTx+fK
         KuMPWgJU4ZwTwNUDqQAFi6d8OLg98fS68iF38A5RfZUsRO+07z2i/5vcY8ZxiMzyIxey
         p/hT3/LcjBsCiUGMXG7IwC3y84uMwrSrM4urBVrpnQpzl+6oIkOc+Z8N4PFQz3Fbkjc5
         L2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748344118; x=1748948918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrzlUqZN0a5R+G7GF9tUab03ZGWFooFwFU0L4xjwtxM=;
        b=ccXjg/FbTBQYBLhmMl8iDdlinTpXMZKZDy1VNDJm8XhqLUA12DqntMSK1n+UIim7BO
         hXXTXF5XfLmzqhBt1MKI2R6Ep25xl9sTIg7ZAf4qgiqFllJc9qRzqyHWGRwKac6lhed8
         CLArRXPkMTpYMBiU6nii40tf3XA/mvkQwr7r8LGEvLMhnJS08vbnpTTV4+uKM+jnYY5k
         UdxpU+Nj7B0Xp9c7dqzPV5Ib5x55ZICoHfkJmmYO3t8yV+7F/vpqDUGtW2eeSddPzBcV
         1XO5G9eeuPMDsjM0INE8zxgT9LYmBr25aBa1dq5dZpa2wQCJYLfTmC3TLWuhnsc6W7fj
         iUvg==
X-Forwarded-Encrypted: i=1; AJvYcCWXM0hFNbX6TEc9vcM1rp3FeA2O+YzoNZNDOz/oX7ypswFEKiro7n3/+oY8blc/KeHnyVrec5CHJnlM@vger.kernel.org, AJvYcCXKLfQw2dYZIlII9U9HfkyeQ/twt3C1IzARHsMSzHma1q2LXU9uq1Bhj9l/ou/1L/oekn2Y5MP8j4uNDWsJ@vger.kernel.org, AJvYcCXlODGlbbNFiQe5dRK4gjt73lrQYZw+t6GRbK0z+XRGZuqc9jQvUwcZBmAIcFLiAxNi1cQNaUgLwb7iizsR@vger.kernel.org
X-Gm-Message-State: AOJu0YxezY/CM0fyCYPjYCb4e3NidxiYC0dtE73gHLYhQ3YSl7sQJlv5
	MTIUeQMR7FVF8KgMv+6tXKfknnJB6nqv0yI19cOfYRB9vhLp210qXFE/
X-Gm-Gg: ASbGnctip6eJW3aoO8Yhg41eJBuzyRKZIOYhk/7M38OsHpluDfhM8eXMGu4D+VFMlAd
	DW2tGHB6Y+dH4p9EumBJZFROb41yn6aG6nlXbu9GsQIYwjpxcl/A3lqydvxCXdVoNRjXXvY8hvH
	VrhdxK7atwPWPJ6wRABnid7THvx4V5Hn9532gIZ3AfCMfFfCBAOQyMFAPt+7mWf1smCNuYDGkmk
	366iXgtxZ9ghwT5A7UD/ZdzjPJTfb7djGX3ACm/XTGYShcDr77EvkCtvmW4QwOo7DXzW5zBk7Yf
	HRP90fw4hYZFUBf5sD5Lj/Mnwx3XI4KGGTBAAHGYnDyRXXUhlFhPxHgKZhCSuSqf8NiKl+MHtWM
	3GU1p
X-Google-Smtp-Source: AGHT+IGJFDt2RJQxu8Iu8q4jKRN0K1XcgwMH030e180iig8ad6QB0tPqnPyZqTiw7ph0nwENS67CkA==
X-Received: by 2002:a17:907:9483:b0:ad8:6dae:11e6 with SMTP id a640c23a62f3a-ad8986f270emr21002766b.0.1748344116076;
        Tue, 27 May 2025 04:08:36 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad52d4cbe90sm1819389666b.165.2025.05.27.04.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 04:08:35 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 27 May 2025 13:08:16 +0200
Subject: [PATCH] spi: spi-qpic-snand: document the limited bit error
 reporting capability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB+dNWgC/x2NQQqDMBAAvyJ7diEJiLZfEQ9rstqFNo27pQji3
 w1eBuYyc4CxChs8mwOU/2LyzVV820B8UV4ZJVWH4ELnutDjViSiZcoJ3/KRHyecK1UxUjEk/xh
 m56NfHEGNFOVF9nswTud5AUPqiVxwAAAA
X-Change-ID: 20250527-qpic-snand-limited-biterr-caps-a198b01c1f0a
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The QPIC hardware is not capable of reporting the exact number of the
corrected bit errors, it only reports the number of the corrected bytes.

Document this behaviour in the code, and also issue a warning message
to inform the user about it.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fd129650434f0129e24d3bdac7e7c4d5542627e6..c2f5ef899f6a60ad98b9d754b7cac1832d0500eb 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -639,6 +639,20 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc)
 			unsigned int stat;
 
 			stat = buffer & BS_CORRECTABLE_ERR_MSK;
+
+			/*
+			 * The exact number of the corrected bits is
+			 * unknown because the hardware only reports the
+			 * number of the corrected bytes.
+			 *
+			 * Since we have no better solution at the moment,
+			 * report that value as the number of bit errors
+			 * despite that it is inaccurate in most cases.
+			 */
+			if (stat && stat != ecc_cfg->strength)
+				dev_warn_once(snandc->dev,
+					      "Warning: due to hw limitation, the reported number of the corrected bits may be inaccurate\n");
+
 			snandc->qspi->ecc_stats.corrected += stat;
 			max_bitflips = max(max_bitflips, stat);
 		}

---
base-commit: b00d6864a4c948529dc6ddd2df76bf175bf27c63
change-id: 20250527-qpic-snand-limited-biterr-caps-a198b01c1f0a

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



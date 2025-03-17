Return-Path: <linux-spi+bounces-7172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E81A6565F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26483BD27A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9924C68B;
	Mon, 17 Mar 2025 15:44:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678222459DE;
	Mon, 17 Mar 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226267; cv=none; b=nX1eu/1OqLP4BfxPWv3CdDxpprWc/pbzHjHZqC9uj8JwZ07Rgm/Yx8p2oixCovUoHGiHT0KD/NBj/05izObPkI3gGUu47A6EMQscO2qA+Hu15Mvl5PB2wJzsU8iQ5zBrpBEkt5V33oyn+p/VKaX+vEe/BL1MxHlCQURsoRWGJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226267; c=relaxed/simple;
	bh=7lqJsGwVtb8Js7p+GzX5jgzbAm4CExvrwoXmyc966GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNwQXyQkwMmNuXPHBI08mGRAgCb5abdzI9+scetfjL0AhQ2s3BIw2lEBn9wd3AY7n2exTRvIXNF8mjJtF+eccQiDf0TevXTMiVSYPrprUfZPL17G11Iyo6VdeqQPvs/PcSFUntSTmn7t7TDOq/ov65YsZxDrzcfUzwlNTbmnFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so7614625a12.2;
        Mon, 17 Mar 2025 08:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226263; x=1742831063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amP3yIokAbOD+ubVkl63TWa65eOoOccbBKc0TbdlwY8=;
        b=WjfTiuI0cYtfd8Mzd5JdOOuURBjCOwQr/4PTJfjPHaRKQ8ntVPjttp9ENac2OEo+SY
         cdW05C6zkRRZRlKDnCcYQD++/TA5WRMXy7xucArCMXXgUX0r80nmM6NkfiDhLxvVsQ8b
         ey2bP3aiOeEGBoq+W0dIrcBjoBR/enNU69YJCaTOH78W8EcNjvujizrvmAp6hA+Tk4iL
         cxd8dHB78QQi+nlfRsVJP83U7EObYMm3uovZ7RlgWfwP2QzgNjfEGs+y7UXBuBDRwYoL
         Km7Zp8Ts3p2/QpbfBgfurqN1rIJEJ7tec8uRVpHzeach7mZ1Q2o2UNFxGc6oHLf1jJRT
         52Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVY7f2/ypqKanrepKWCmlyxBVIG4kSexCBuk6udR25Tk7IIzZE0R/Ne1UxMyxYRBPhjDHIFDROEURqZ1yE=@vger.kernel.org, AJvYcCWrUOFm7d/N8BSvJx/RoWjOIltBlHAYw+uhsW2n0bVDE9lZdIaC2aEvWLvunpbvjVtbFfIUnbzuA+kA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96VY4AitlvkeBN7cnQ2N6jdhiyVL8s+F5668tCq1HMIXAt8bH
	rUJr7sPLnXX625UabzBaJ8c/MAZwSGK2j6/HWOFRKGXgUICvm52I8yGq/g==
X-Gm-Gg: ASbGnct1Sds7OLBxyUdykIK92ly6yD2K8/830LRi9SMVK5VG3wIVyK5cLxIlCzzSbWz
	WR+s4K8xIWUf8AG0dPi2h8a4+yxBV+AN2+G897z0QFUC/kGga0EX0SpexnnyAcin5siNxGpBDQ8
	goKXRHq1oVU+KAdIboNZqYRxxskSJG9cxZKJn4QqiMEwI1cdjwJAOgqWUIlV8qzhFP/ygsq9dja
	yZq69xQluBiiOJw6z27Bz6Dk1OWEVcA5cE7Yp+sG6dUz5C45CxRNwVNHpKNDwWJW1I9Qqlbr0Oh
	hX2eW9zRgDinDwXHtLll9ZDEbp3vviFV5GA=
X-Google-Smtp-Source: AGHT+IGq7DZ5UNLafXVHskpiX36HCMaCB8WgZvhYhy7rMQH4hd6SMHH5LtASdYBOdAjFfzFj0Ob8Kg==
X-Received: by 2002:a05:6402:278a:b0:5e7:e3f3:8647 with SMTP id 4fb4d7f45d1cf-5e89f645652mr13935469a12.19.1742226263097;
        Mon, 17 Mar 2025 08:44:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e69csm6060797a12.3.2025.03.17.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:44:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 17 Mar 2025 08:44:01 -0700
Subject: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-tegra-v1-1-78474efc0386@debian.org>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
In-Reply-To: <20250317-tegra-v1-0-78474efc0386@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=leitao@debian.org;
 h=from:subject:message-id; bh=7lqJsGwVtb8Js7p+GzX5jgzbAm4CExvrwoXmyc966GE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn2ENTdHMnT2BPgxtv6falAa6UurBPSw/ItM5zr
 C8t8T0iQ/yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9hDUwAKCRA1o5Of/Hh3
 bZZDD/0Rq+kMnPCrxh9sAeXLJ0DccZnOBpN+rSXFlmJYC3HJdss2iNkYYyxcRga8Pkf61PUbofa
 31E6oZ7NyjJsw7/Ay+5scN0ii+GUFq2bhU8UOX4YfjlL7/4VT7I57vhMoqEQDuBkzCJ9XG7nPyd
 5Zkzpe2KBMo9uDPaWBdP/86jrxFBJMi7ElyaV+mwZuBhZ3tn1mpUJrRFnul7XgR6zIvHJgjOO57
 UcOjFvMgb+ZiEcNSUTqo6kKhI283DsoIasokRnbO2EW/Vn+6BJQ0rfSuKTAk0svc66u3HsPjILw
 q0Y92qtqokaXZVTUigtLCPFxOo8fq6SWSnrgWzNi9+jD7Be+JlGpIAfGX0Rcupoi5AwUnQTGSXT
 5B0BSkZcZyiQ0EXMcPUh9gtgMhqYxxlQU4c+hrpkjT0MNdSoX9HeONlMtiz1Eb4/gVpf144FSY0
 p4yKtmX1o9JCpajIvGZEeo40uyyLVmYjqiPfJPwmBqICSZJb+sVjxV6XdMqi/A9ngsMSjjdtTri
 B8SGVNtv19AWPozbvOoDgL6n+bRTomTCbSloca5QjshHlbyE2gvwfgQYUr5SMrNYPu97VDsim60
 s6s4glHEMPSDZ2aQqBRTWVN+fo2rS+I3XAiNqKulHtv61M8EDzLSw0dBr0oQSUCgWLeDpSxX+5/
 K83x1Hhz06tFVhA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

My UEFI machines with tegra210-quad consistently report "device reset
failed". Investigation showed this isn't an actual failure
- __device_reset() returns -ENOENT because ACPI has no "*_RST" method.

Replace device_reset() with device_reset_optional() to prevent
errors when the reset method doesn't exist. With this change, the
function only fails if the actual device reset operation fails when
called.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 08e49a8768943..9027f995a6669 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -999,7 +999,7 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset_optional(tqspi->dev) < 0)
 		dev_warn_once(tqspi->dev, "device reset failed\n");
 }
 
@@ -1149,7 +1149,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				}
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset_optional(tqspi->dev) < 0)
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
 				ret = -EIO;
@@ -1606,7 +1606,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset_optional(tqspi->dev) < 0)
 		dev_warn_once(tqspi->dev, "device reset failed\n");
 
 	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;

-- 
2.47.1



Return-Path: <linux-spi+bounces-4196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAAD9522AC
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676A8285A02
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F31BD018;
	Wed, 14 Aug 2024 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acclWCsq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589301BE84E;
	Wed, 14 Aug 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663774; cv=none; b=N5w8FqQ3fLCQ0xTJkBlApH7ruMe0vI29JUCMQYXIapjxeIY61fMVeL68HeVv/vt7xI571Vz3/FQWdvddweQZJGG2un730UZ6TYLF8A8+xSeAjQ2y9xKa0uNQR7iCBgdHaRVtifE8nktbg2JzjBHsaHfz5X4WjjYFh1VQoV21RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663774; c=relaxed/simple;
	bh=8vRi6gMuTJCvWpLXDF66FMDAEEGkcYr61a6GSb4dTo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uw0Bg2UKkFNk437h+5bNa4OAp3t0ruQgvghjlUIU/RD3eNsFWlFcWiihJTd1hBHCKEy4IVD4PcURiJS/+Uj+pevsoo96jdFMHzlLEIXCqVlNWh0ZlTvA9/q6sRLBOVFAQQdIPFBYiOzWtYnoIpJHLCvJUzMQtYaXwRRcNF5EFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acclWCsq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75abb359fa5so37897a12.0;
        Wed, 14 Aug 2024 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723663772; x=1724268572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsGUvb6nFho8UXWLIlzLPgIbTCVi+qz8AQbTtLtqEhA=;
        b=acclWCsqyFQl0gnVofuGTMLHZb3IXKTs4x4aCr0WfNaHjl8ZGpb/r3Myc+pNR0FbwO
         WCA5GEnjnF3/fm5M/Sus7YZVn+1VJGjBMPLmOVcyq7Qg1/+MSHl289Z3a9Hh506WEX0V
         9gJdU64lNRjdbp7KA4L3Ta88mNNhU1Od6yrMZy29fkU1g7i9s+QbGdVai/MyDSP2BKOP
         r/rmJ/G7kA4YZynyqDO9Ip+LpBC7AW+17Xf73JrMRO3bOi3whH4onll0sUz9yJbldWIP
         f2TTVGWLvvUwiAAWyF0diEobDcNp/zRWKudipn5OYlOVA5Lqs8/ALDAMimtC9fYtPbAz
         3mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663772; x=1724268572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsGUvb6nFho8UXWLIlzLPgIbTCVi+qz8AQbTtLtqEhA=;
        b=IFVeuUMDNjbzbcTGC3slksS5lcWfRnjd11xLuBFd7a/pv7ykXjh1b3ECFgSZN4kNX9
         1jGl7tB/fqnM+r5HALTQmLUWPzkkSo5TGNbPR+JLwgVb4ftYwV5a8RdkJX+LBVi4vh7o
         bJilLfp5T6w/MDmRnt5wbyFdGi8uMADN3L0zrAa6biYFKQvvpOX0ZH1lRooAJylMM/JW
         0lMmjCiZvwMzqnxP41J+t68kmrD5Da1DjTQIiwCf2r5DqOll/qd9H42tvnnU/fGMyc8j
         d58THqvaGi994KVXb2zIHe5CumXk21HkAUc3bIgAR5kT+cbHQ9uFMnTmYvXWaZbgUZmb
         JdfA==
X-Forwarded-Encrypted: i=1; AJvYcCVJQSkpf1lYqm6A4kx4/MDHpE++x0X13qilSHINRwMf8laabzcjZ3taZLUDELNpxM4cBibW3+OJr2FPaxg=@vger.kernel.org, AJvYcCX+OjCz7NHA96nJ/boihl4JKDtra3VUgRksOO7wiiSkM30jdP0MjKqVm8lFn1VG3Ow5znymJIbl7/6I@vger.kernel.org
X-Gm-Message-State: AOJu0YwEb/eLXkNZ6xP3OluJXv9z0r08wfzzzh736uBsR3RgBNWvw4+u
	goEQd3bMrjhw4Z6y5JBSBsSS4tpmvy7g+velOfbg33QsbDsDLjhx
X-Google-Smtp-Source: AGHT+IHospHNPoeh5XKwhWBVCuDX8BVHQu6fE2KBEqXKlLWSK7Ml6eaVy3HxHB6s8a+gtoVeqqOU1Q==
X-Received: by 2002:a05:6a21:329f:b0:1c3:b106:d293 with SMTP id adf61e73a8af0-1c8f9faf08dmr135268637.3.1723663772363;
        Wed, 14 Aug 2024 12:29:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a55b4bsm3540653a12.73.2024.08.14.12.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:29:31 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] spi: zynq-qspi: Replace kzalloc with kmalloc for buffer allocation
Date: Thu, 15 Aug 2024 03:28:39 +0800
Message-Id: <20240814192839.345523-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In zynq_qspi_exec_mem_op(), the temporary buffer is allocated with
kzalloc and then immediately initialized using memset to 0xff. To
optimize this, replace kzalloc with kmalloc, as the zeroing operation
is redundant and unnecessary.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Build test only.

 drivers/spi/spi-zynq-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index d6325c6be3d4..b67455bda972 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -569,7 +569,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	}
 
 	if (op->dummy.nbytes) {
-		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL);
+		tmpbuf = kmalloc(op->dummy.nbytes, GFP_KERNEL);
 		if (!tmpbuf)
 			return -ENOMEM;
 
-- 
2.34.1



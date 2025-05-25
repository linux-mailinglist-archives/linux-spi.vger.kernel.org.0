Return-Path: <linux-spi+bounces-8285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF0AC35C8
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171A81894B84
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D191F4CBB;
	Sun, 25 May 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Belfy/qd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5021F4725;
	Sun, 25 May 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748192754; cv=none; b=kNtNFprQy54qVKzDF6OgmS4xOc0I+IBROlnj9RpmoInS5mnf33OfosW5OR68EVxSZ7pXQjEM5WFfPKPwOm0KMk4AheM/UuFSPl/MQowUJ+R9sFNhJ2XnxM1FjMePPho+ClXLa/s1r9YETDQRlwOTaGsj5WzgnuBvK+mdGGvXYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748192754; c=relaxed/simple;
	bh=8lKrQhMe8HS9CsbhesAz8iyWZNUGIJ7KEPGbgdo4AFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o/lYDAsRdMN2dq3DlSfk6o+LFWsH4oE5N/kZ/EkDtVdP71pA5NGubJXeP+ps+kwfgfo6M7InKkitq+RyzuRvoORBaxrblSKYBT9Ckozy7RvpE5u9HFn5qAUyYZAki5bEmP/YH5U8al2prFVj4HplKt26tjrBhckQZZx/pqrAoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Belfy/qd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4c9024117so1131187f8f.0;
        Sun, 25 May 2025 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748192750; x=1748797550; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSPtkl2k2o6TvMihlt2eH/B28rLRtVyXETO98Nlddcg=;
        b=Belfy/qdROFhVDPKlZJsTED3s2UFTgL/omqUMiM8Vk5gIi6xOtlVaZ4eL9QB6bO/X/
         HIvt+fAVyKKKcyAP9mf1vcHgmWM4M+WNtcCiIDfKWbqJ2ln0ckafETDHIgXy6YSlwgGk
         Jf0/hWtdN+y9uu+LXLl0DsW1NOY67GVJY1PMeASWUhZZKc2V2OC6PklhtxFZkvgWSgtg
         z4840hZyko3qluZuYemq/B+zglJDdA1nV6O/i4he6bd098SIy2IIVPQVo9/jdE/KaV5t
         CCizMxt6BAag44wgCUQLVVQUGRoj4dgBF7Fv0glkYMqW+iQCQZlSMjr2RwTHlWa6JOEg
         Zbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748192750; x=1748797550;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSPtkl2k2o6TvMihlt2eH/B28rLRtVyXETO98Nlddcg=;
        b=ZqI3e/3YbOFONWjTtN8+1FF3tqWUqVInXtL+a1L89Rgvl7WBawra3AOs/4rTXRdvnY
         GMxRYkF/2sPONDIn62EWRlSILxgyNlACZEi5cUrqqOON+hn5uL4uAgltD+al1SLOeU63
         HrZ9Y1uWZi/CfNO75O3maCTqqD7zMcSk5gCoWN9PeWinm7X6CunAhiNOpneKfBD79OBf
         OHqBITJM26DpYK0qSH3p86yGSr4tVwZZz3XYwcdl7RhQEZZPEsiPgMwiFgSLurEMZWGi
         4RagPPpQqKJ/5uhgfZ1OZIroA/V+f4uLVKHUbdY1u8LXX/S3C1g7Cxz6QXFtOHxBi0nl
         YzVw==
X-Forwarded-Encrypted: i=1; AJvYcCUC81v3WHZGxuwt2nMWAcd3j6eCkNzP9ypgam+EOuVRpau+fg4o0TrAvTGnZaj5uRW4cAmRYUneYNrOyjYg@vger.kernel.org, AJvYcCUw1voyAQK8rUNsaxlwrEHRFFIHy6xf3oOGrqz0c5hY/47omnnKpmEshIIvQW3m3oZ5AvNbQX8MPJVfztR3@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAzX9jb23SAAdWj25/iH9BNh7fCpG8Xb3tuUtea7XqHDdzwIB
	SO6+FElCFxyWZ+TmbVeVefakPskaokI8ZcJ41i1rBSp1umaRKb13nQ5kEgu68g==
X-Gm-Gg: ASbGncuJFR6sQRxpyYFZeyyvN9cuNrkhQWzG2AmnBUVIThiJG/8Cg5omToWpqbX8krp
	EcyTFq3PxtuqE8VJe2RNyZxBrTMpYGEGG7vPIsc7VdlLQVN9IjbxliWqHcgfLKzftVzSCGWsGbX
	/d/EnF+uv2RzXbyZPCbqCdOQBl4dW4KgAGy2ouEcv3FP5SHyqgI33wkx1vrZ7fcmnctH5BqGOeE
	DGeqd87F96QVYgEuxMG/o5LD//jlEQEBERaMGavUdVQaULc0qxUW6xw6r2g4XQLo8omTEGT8e9E
	3p6tQogR6nTwzoUUp0oWAPyx7uE3rXg7dViocycURPzXQlEThrjcxJF6L5RQ/oxEXMFlnOxLHQU
	r4rMG
X-Google-Smtp-Source: AGHT+IHrqdaTfd2CvQtrbD19G5LSxUJsrVd7AD2/hDFFT83q8/zfeCWuZFodkMnHDVSIbhoYgXl5Kw==
X-Received: by 2002:a05:6000:22c7:b0:3a4:da0e:5170 with SMTP id ffacd0b85a97d-3a4da0e537cmr26224f8f.27.1748192750374;
        Sun, 25 May 2025 10:05:50 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a03fsm32317405f8f.22.2025.05.25.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 10:05:49 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] spi: spi-qpic-snand: avoid memory corruption
Date: Sun, 25 May 2025 19:05:34 +0200
Message-Id: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5NM2gC/x2NMQ7DIAwAv4I81xIhypKvVB0MOI2HADUtioTy9
 6CON9xdh8oqXGE1HZSbVMlpwPQwEHZKb0aJg8FZt9jFzfgpErAmShGpZYl48IEhq/7Kd7g424k
 28uwtexiVorzJ+T88X9d1A5+0GMlxAAAA
X-Change-ID: 20250523-qpic-snand-avoid-mem-corruption-301afabeb0eb
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'spi-qpic-nand' driver may cause memory corruption under some
circumstances. The first patch in the series changes the driver to
avoid that, whereas the second adds some sanity checks to the common
QPIC code in order to make detecting such errors easier in the future.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      spi: spi-qpic-snand: reallocate BAM transactions
      mtd: nand: qpic_common: prevent out of bounds access of BAM arrays

 drivers/mtd/nand/qpic_common.c       | 28 ++++++++++++++++++++++++----
 drivers/spi/spi-qpic-snand.c         | 16 ++++++++++++++++
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)
---
base-commit: b00d6864a4c948529dc6ddd2df76bf175bf27c63
change-id: 20250523-qpic-snand-avoid-mem-corruption-301afabeb0eb

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



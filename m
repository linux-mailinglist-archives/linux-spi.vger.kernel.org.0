Return-Path: <linux-spi+bounces-7507-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B31A839FA
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F317544010A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E6204594;
	Thu, 10 Apr 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rztw6B1o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7222045A3;
	Thu, 10 Apr 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268198; cv=none; b=hdXt0EWWt4s/yri+yd8xpukxIMxnKymBH74g+T8FOFvFJvZKJAtKR5Xaa+Y7co8StmH+4yEg5p3vutxeK/yD5iVfEPUTc6CEZ2KLh7nhgtRMpPNXuQeleGKY2Nz74XoouYXmR9V6loTsjp/vhV82NHXOey7XyluRbLYPVwK1fWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268198; c=relaxed/simple;
	bh=IR5zfONGQPrG/O5K6oH/e0DDicgiAHZk9hVpRV/9g9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LosVU+gHyEyn/mkMWmXhf1r14S4kr9ckWujaaguIptM4A9x/viqI6x9ojoGjkHKmwhV3wCSCphfSBwntfPc5eWYp6jThQD5uFxuccE0W6yECl4MjAm17iUmL9KAwGpYtrX62ht6bcgNkfERB+S8KwlW8kAG9hwjMv8ctqn/ieA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rztw6B1o; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be49f6b331so57582585a.1;
        Wed, 09 Apr 2025 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268195; x=1744872995; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stSZx6MxVd9/oupgvZW3EPBQ9cRhM3rlEoAObWRga44=;
        b=Rztw6B1oyj1LLSQ8C9P/yw82qbME4PB+0arL7FtuV1tx5lZP7UcmovKVT48XdGeDmF
         pMJg9KcW1ERyGn7ZnjEIo8AP5JbIKaMK9EtTCf8cEFlS5hM0leDIEZ5DSnHL6DbXNrjg
         C/sz9vVp8HyU78l0xyXXBN+9fK11+HJdzaMNBJmm9kcjFm2XaE8dB83s1z3Z19JYd1Hw
         fyN8H/lHLhgXh/nMHU5q1ZhH72cGvis5iMVIw/u8bWByoaDFQLJVdGkZX5KqdI7ppY2/
         GvTNxRijanxorgPvhUeeh/doNjFYPe55MrUpIbOZGRqDVsIRJm+HQv5KRvKht5v43AFS
         MVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268195; x=1744872995;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stSZx6MxVd9/oupgvZW3EPBQ9cRhM3rlEoAObWRga44=;
        b=omg+g2rtWtSOBSTerS+iGKaTy2EdiySqCdGIqArWS2KWheuh0t3Hgtegx+P2Vn/B7J
         1ovTLjpNIsz44RgwTuuKuWZpiP/wfZlDwarKlrt9hvw3NL0Z3Jh7vzAPyXWFS5OWFPq1
         SmKaUPyDEtU7QHFFZQOabbxfcS8D2aIuiBiuvCgfdhIQPpsQVQ/woEc5fGvDb/D0WfOX
         fa+Y797ykcIR04Ik4tRz/dItnjsnKMBa3eVRbe8IOMmP2Pyu6HONP3vbzq24SoF2VK9V
         7yO3rD7XRANGGe53Kvetjiz+CQqAyiMHGz5HKqG0IGPlPbJ2FpiGWZIgqFZrQvbntAvb
         yynw==
X-Forwarded-Encrypted: i=1; AJvYcCXwjKthm4+SKesAopCguO4VqT7y0EsUcxIGeJuqDTDq+XTBNPjTViHmTH/J532daqQOgGE+Ao0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneMz/+O6jLNp4+GfJB4l0s3gGXKRfwHhk05/n606k1FRNnOz0
	XyyxSEqDYfB6lMcFuSbsw90/8BhG+ljqBlYV+7sPPMfK5Fa0yNN4QqMn8AoU
X-Gm-Gg: ASbGncvx1YZXjPbJVeHDz23jHcNIXUGjDxvdrbMEyQKAZ63mS1EIMCgZzuP2C2ccPGr
	4QSEqBj0pMfiiOejRppj3Fgh9UqU1AdWkV4fHBJ+hh4NP/efiptoaYAHEhoEibusN1ybHBwk0dL
	CFLg9EABnkUpE7ARVUy02YKIE2WDHU30SLNjMgAep/LplXQlIE+8be0hdqgkF3iaqhIK+bamJOq
	bFzMUVQtHY7tsGF+ez3KX1yoGWLOuDTS8S3xKR6lVs5vmJz91dMQwUdmB5urqREGIKNLbSdvGQL
	4VBjntaLpPWsZ1/0vJTYHEgI23oSU+WRJ/b+s27Jmc/CX5IVtP8=
X-Google-Smtp-Source: AGHT+IGEzb8q4GErf4E2NhVLOjPHUdc4Kh3rGDJV2EoEuCzx8hGLlVjXwE9MK+5LWlUf1cjz6YXrXA==
X-Received: by 2002:a05:620a:3949:b0:7c5:79c6:645d with SMTP id af79cd13be357-7c7a765500fmr240369885a.11.1744268195554;
        Wed, 09 Apr 2025 23:56:35 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89515e4sm46547285a.26.2025.04.09.23.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:56:34 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 0/3] spi: fsl-qspi: Fix double cleanup in probe error path
Date: Thu, 10 Apr 2025 14:56:08 +0800
Message-Id: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIhr92cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3eKCTF1Dg8SUZANLixRTMzMloMqCotS0zAqwKdGxtbUAgQSRAFU
 AAAA=
X-Change-ID: 20250410-spi-10adc098d566
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 imx@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.14.2

This patch series fixes double cleanup issues in the fsl-qspi probe
error path and also simplifies the probe error handling using managed APIs.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
Kevin Hao (3):
      spi: fsl-qspi: Fix double cleanup in probe error path
      spi: fsl-spi: Remove redundant probe error message
      spi: fsl-qspi: Simplify probe error handling using managed API

 drivers/spi/spi-fsl-qspi.c | 77 +++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)
---
base-commit: 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18
change-id: 20250410-spi-10adc098d566

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>



Return-Path: <linux-spi+bounces-7856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A7AA7A42
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EC33BAFFB
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2181EB1A9;
	Fri,  2 May 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJmQqp/M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8742DC78C;
	Fri,  2 May 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214297; cv=none; b=mH0DNZK0V+GjIb9WjMZ4i23ZjRtJXhnf5zkhB+6Fhbg50IxfLL+I6K+aAMKC8ig4VG98W5lNjO+HGWL6SZOzjK7jndnGbhvRKEyUdNbV6mVxuMfxoObU+65PSLqsn3K1w2OKJIaTXXHmVSGKMmoJkl1kkX9FTjhj/r6a0/8XuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214297; c=relaxed/simple;
	bh=6YMyTJz74oHgAjCD5fmF2xDxlcIzt43ugRi7JkevP+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bq1JOdH9lNLBlfT0yNqV5s1FWJfHMQ9Eqi9lAvTxKG84NxodvtIqPeK5ocrqcJ3HEpR7wc5JHmBE+knFqINfwSXniyVkgtGBvo/TefAHx3Zg8mK2jmbj7TdA8phgNzS8+B3jwYVTGgXrRcXTBuYv1NRqbF0Vhzr9YU34GJLh0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJmQqp/M; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso442031966b.0;
        Fri, 02 May 2025 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746214294; x=1746819094; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gZpvwlgFSLmiwWzkOrn/YxYzEW5jmXin3hp9eGRugQ=;
        b=DJmQqp/MvKrH0nSMLPWX6YFAZhYTeZgwI0hQHS8OO6ji54Y1OL0bHsDuHTFwGq8mt6
         CZszcfVBxv1LgFNiEBi40YMDcphKUEvvjPV4OolIsseEX+jckmb0IoIxzMgRITyc7D84
         vc4031vmsRKV8k4TzxyjRgDGG/hPSWh20k8CNuA+xzLihwAkmWGirWYcFBkVf2ZLGL0O
         3NbBX7zpgfVpASu5gbNISnn/lQ0lOfE+Bc57LSUYhGXdWN5TMt23+Ovdjwq0FXONzF4G
         RveVy/S73QnzTwB0Ek9dBHcu864cQ2vXB+KThvlT6m5GYGwsNZkqXRgBZu7I60r/l/oB
         FvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746214294; x=1746819094;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gZpvwlgFSLmiwWzkOrn/YxYzEW5jmXin3hp9eGRugQ=;
        b=cP3FcB7dXbBJmvjbBrC+tgRGIZYx+bhh+Sqgqj8sDb7jDtO4XdOZwOltHqhw6TzrKa
         AL51Tk9OTlTseLo57nm1MXtdbHDzYdojPTi7Asf/eZQvXFQbndzFh/DMXlrF9M0hevQ8
         vTgbFuZ3QYwY8VrTWIwxTe86Ql/m3U9S/Ow7PHTtgR9NUAZtX8YyIGt0TKot5JWGpksP
         PqBN5Dvz9quMdhwAP0BlFWDhwDy5xW53Gq5E8vkbwGitJoeAnQKGfu34YesyWte20vd+
         irz3byx+W1bnp2pR0ShHSPouGGTMLeypru5cuDT9F6ayhIz0vFr3d/HUrmII+eisGXR3
         MMHg==
X-Forwarded-Encrypted: i=1; AJvYcCURycgMdYWWa9K2TlXsPCFAS7lmT8C3HxtVl1LttqQ4/rJHGTmHGBSrtAXckcnXZU+tMiK6tO71EyLXsUGM@vger.kernel.org, AJvYcCUWwr3piRjPvl9/8yMgwccURsZXC2tVZsV5XYCyzBVHDLD/asYifc6KOuFAH0pYl4o+3HcgdxkUpvF1nkSO@vger.kernel.org, AJvYcCXGnxAjcpvkRxuObObhHmtB3XGNM5YPvv1iMet0mKgs1axMhE2ughvFG3Ul8xabxpr6KBz0Wq0v4+Bo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UIEdvJWE45hB3IFbqcxyv865H7K74r5vHbp7/ycrqnK5WUAo
	cdhAllremDZY6KL92c3WmJFbw4H9kyvd/GgAfFDHcWWJGCQnm/xw
X-Gm-Gg: ASbGnctZxlLiM06k/FBrx1vNO8xbiEXAMY/Nut/aVF7TFSZ1gFmDSuJ+T7dV6hPplGc
	bpL05s6h7TkhzKUElypfoJpbqF7k5AgdaDXq/u3tc5BYw7fZ4x8nuLWY1y9WhXIg9qnE4fIKH0H
	RlMILLjXjg4cx+KJnhgFPtR/vEUxOsZ+5yWQB4sZUC6+v5yI60jWknEzqP5v3FrJnfuWsrJS9Bf
	u8M0PP4zRLpNUeZVx4djc6TTSYNVqMLDgTj7otIUoVjlhNvV2KinsOscv4Hif23/ZseKMVWwOs0
	48ma2H+UNBo/NcFBDJGczm/8fpURSP7HTqHaGJjeWK38dnSUvVdBjYDD9Wx0HX5DhVAmiA==
X-Google-Smtp-Source: AGHT+IFc3Ur95DNTkNHIKLCZ43haAEzHVjbUdImB5kP9fas4dW9nGVrmS3nnfQ77GgSrzq8fbH6FjA==
X-Received: by 2002:a17:907:868c:b0:aca:a162:67bb with SMTP id a640c23a62f3a-ad17b4708fbmr469455666b.4.1746214294085;
        Fri, 02 May 2025 12:31:34 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad1894c025esm87824266b.114.2025.05.02.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:31:33 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH next 0/2] spi: spi-qpic-snand: enable 8 bits ECC strength
 support
Date: Fri, 02 May 2025 21:31:15 +0200
Message-Id: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQdFWgC/02OQY6DMAxFr4K8rkdJXGjKVUZdBMfMRIXQJhlUq
 erdiygasfy23vv/CVlSkAxt9YQkc8hhikvQhwr418UfweCXDEaZWhll8X4LjDm66NF2oaAwo2e
 rjr1Xtj4bWMhbkj48Vus3RHkUuHyuSe5/S0XZXv8NbbX6yai9/zq6YZgYqW9Y913D9kTtrGG/b
 SNrpffk7IbgXZF1HVnqSIjEkN3wzmVBnsYxlLaamy9dY+IjXF6vN0ZGgukRAQAA
X-Change-ID: 20250208-qpic-snand-8bit-ecc-dc804fd08592
To: Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

This small patch set adds support for 8 bits ECC strength, which widens
the range of the usable SPI NAND chips with the driver.

The series should be integrated via the SPI tree, as that contains
prerequisite changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      mtd: nand: qpic-common: add defines for ECC_MODE values
      spi: spi-qpic-snand: add support for 8 bits ECC strength

 drivers/mtd/nand/raw/qcom_nandc.c    |  6 +++---
 drivers/spi/spi-qpic-snand.c         | 21 ++++++++++++++++-----
 include/linux/mtd/nand-qpic-common.h |  2 ++
 3 files changed, 21 insertions(+), 8 deletions(-)
---
base-commit: 39d6783f6488786301f36b0e7c619f220c3e8d2c
change-id: 20250208-qpic-snand-8bit-ecc-dc804fd08592
prerequisite-change-id: 20250320-qpic-snand-kmalloc-3f6c1fb6c873:v1
prerequisite-patch-id: ec9e9786ca59fcddf9502d0ba5b0f4e6593aab62
prerequisite-change-id: 20250501-qpic-snand-validate-ecc-383b3e33e238:v1
prerequisite-patch-id: 7a549e08b3075d20c5014bb3d2151643aa956f5c

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



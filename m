Return-Path: <linux-spi+bounces-1138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6525584C95C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839211C25793
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4E914AB3;
	Wed,  7 Feb 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxxyNyE1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C43225DD
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304523; cv=none; b=eE5LlGXQrR0uR4Zi70WkfWlKUHFop29xJ9iDTHIr0DaK5Ef6ypObrvPykuTbMqch936+FlEzxd1W9V+42BsCImmf5SJoCxsKBWWjFaPJHi3/5gFbGQhYmxTOmggph4khccppn0w1UI7FgFqu9yovZ2iePQgzOSJ67sJQsndXLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304523; c=relaxed/simple;
	bh=SCPR2qSc7UFQAu1LKrcwc8/FX4vyYYychtz2gG6sa6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+gLJk/GFdWoII2WZ18dgH5bejAY0Lp1B35CwQYQbXD+PaPMm3+RUJpqMi57c3u4ZF0iYy7PozJcGbbjkKqNmzKSeiXheO3P//QZwhk0aUeNOoKt3sMeg7pD2PZo9hTOFQ3MVGsGl2ZKwZV23QxaawIXMMnEzsqAGXuC+CPulVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxxyNyE1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511612e0c57so911368e87.2
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 03:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707304519; x=1707909319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMnb5HJhS7G41QVRQROXaO1EL3gS+emI2A/pWCIDppQ=;
        b=jxxyNyE1IUdKZc5SKmskvucNqSysMFEmU7tsQhKxVdzHTwpgqnXWQeYXgWILkJDJnX
         I1tb6tFWJf3Gd04KqBRKuvXhZ68o87bt4oW552IC0blmsXnKKW60tE1oGQbYgzVLzHnd
         bVh/TdhpnrW+iwaZ/ROpSRMzWYFskbWRnrdCNOvVrU3vjdwxA7R7zoKblSXvwlFABn0t
         wCcdfnYD5Z8nwb5AwvUIGaysqtoE9D76ueJb6lTvn3C4LnLf+Uq/LTOr3achFKttHT0u
         S39+ffenPB9zA4uc38o/NvCPZUBC8nO5hnqf0q8jacsnE14URUBuqKlNmEb5FZecC+sB
         IyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304519; x=1707909319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMnb5HJhS7G41QVRQROXaO1EL3gS+emI2A/pWCIDppQ=;
        b=WZOg+zHReZoVsx3LXzc5MjfcSYUkrnPCW6DrLfX/D0krFY0LlVhieXT592p2FXFM9r
         TiTMRJHt88GSRrZ+jt316zTK7qWIOVlkn1cyopUmZF6oG0lSFHWVbihhFKyYhUV2a1Fc
         bqvmaYeK+bu0suxz2hb0m/7jmMFXfuylZRHd8zgUmCTskmepmPtRPe03hdT2Y7N5a0/5
         o4edEMnKMiu5uuNBxZ+52u5jLBFnqrBHyXFvflfwRyPZ1eErq5JKKiOlBApPPJmiv2l/
         RscYKgGyVDESPCOailF30wnxouXhcS+SjH8zjREUYxqBX8TSSy0NeHlYUppvABsP+QVx
         hlnA==
X-Forwarded-Encrypted: i=1; AJvYcCXvFI9WY7yDGhHAm2CK1qZoKLrvmpBHXU+/3EiqfLhrKiOUJqA56wE+c32YOMq4NXZ900HZNw01Cc42t4h/HrXQdzM0AyhNDSg7
X-Gm-Message-State: AOJu0YwFAnIDD3R6KjWwdYaUn82uuh5InwgWz6lj1LAb5GwYY0ylwlGk
	JhdEHOMHA8IFlnGzpmEzkAc2VWX+YwaLPUMZ6y2WkUzWn6nE7I8emSOw5KmJMKs=
X-Google-Smtp-Source: AGHT+IH3+SKj/e8TPmX4R8reqgJaV+c9yh5OZQbKxNfKFS1eIQzKy98A8IPXAhgrDb1YJy+B9/KSCQ==
X-Received: by 2002:a05:6512:3d29:b0:511:61ab:406e with SMTP id d41-20020a0565123d2900b0051161ab406emr3012942lfv.28.1707304519410;
        Wed, 07 Feb 2024 03:15:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUzup+s1uQRbpAdflsODdHWm0qj4MlCpwuH2pfrt2Ir/2vtrkZaqGew624khQQuCwMkkDJF8HQs/NrowL5pDYpkzjrtCW8w0gfqJSLRjPFJEIlrJU+8UG6QL7CaK0Ri8d/9ezqfUK+oKZIT2b+A4yYcGJNZI3c2SP/jyw03pFF6FeB27hBaKu+yveWvwF+pmiCguWPXUgt19TxF5HTWQy4KRTWHQi5TVOk3SN3g+z1cel7IinEo1kMR1cDNKe4tx8L0J12fPKBd+/MQnxfrRe3ySpvKGzK5n6ne3N8sPCY9dJZ08Jvw51ouoVVXlu528M1b8vRDdydKWLjnVTCIRXAlz0vIrTnJUW+mcRbfhxJm2n09xLs5giQWa8BcWl5n3czj93UghepfqqPKGM0XJLSUCUPDJGr7Vx1W2lAqE2MwPfTDGRqO22otQzHjwULgnVtMer3s4iffalzM+9FDulnIxFf4cdpKNCQQWkDWdGSuKDZ0XdeeeDgau6IEIE/RMURAXGU7TcUcKLtD8T3r8bF8VynxT5gQuzTa4OL5sA6JvEu9uniF4lU3sj1qkRlqZo00EabG+I5IgupFeRSEWYdhA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040ec8330c8asm4983260wmq.39.2024.02.07.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:15:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/4] spi: s3c64xx: add support for google,gs101-spi
Date: Wed,  7 Feb 2024 11:15:12 +0000
Message-ID: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This applies on Mark's for-next branch. It can be queued before the
simple cleanup patches.

v2:
- drop the include linux/types.h patch
- patch 2 is a preparation step as per Sam's suggestion
- contrary to Sam's suggestion, I kept the style for the
  s3c64xx_iowrite{8,16}_32_rep() methods, to be consistent with the
  generic implementations from asm-generic/io.h.
- s/just/only
- collect R-b tags.

v1:
https://lore.kernel.org/linux-spi/20240206085238.1208256-1-tudor.ambarus@linaro.org/

v1 was derived from:
https://lore.kernel.org/linux-spi/20240125145007.748295-1-tudor.ambarus@linaro.org/

Tudor Ambarus (4):
  spi: dt-bindings: samsung: add google,gs101-spi compatible
  spi: s3c64xx: prepare for a different flavor of iowrite rep
  spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
  spi: s3c64xx: add support for google,gs101-spi

 .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
 drivers/spi/spi-s3c64xx.c                     | 85 +++++++++++++++----
 2 files changed, 71 insertions(+), 15 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog



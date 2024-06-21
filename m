Return-Path: <linux-spi+bounces-3531-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2811912EDB
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283F81C2241A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62117BB12;
	Fri, 21 Jun 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mOmvYGs9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F017B518
	for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003101; cv=none; b=OxagvJZRKK84cR7pi5ecSOlfpsc40kehgZjfMlDaOXxhKFNCmIWdJZ8aJTKw7mooKY4/nRzftj5soml5d6R/q3ov6E5LXNAFOodUgTcfQS+sUCeFaDd0q1HNqKsSzc0h6ZmGQOp3orustXbc1mFJYcwqmfRMdn7DqqYw+ao1WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003101; c=relaxed/simple;
	bh=+CynpsRL81h40b5tqxPnjqbyMrBT1lpA5JK1F0hNPbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WybGdSlFY5RuzBUfnYrKmpRYgFiwFClWPEWtM3l09G1MoQ9CSjcvqDECHqyyizs+LwJk8FglETX1fYk2q8vf1Vw3hMXRR+pyogRgWPaqx3ymWAwftsYob5Cd/b+dtbT7cwiMt107xrDAp/FLwcQ/V8a7VR92pQ/Q/xTD16VFRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mOmvYGs9; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d21b3da741so1283743b6e.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003098; x=1719607898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBilKbtyKaHgD4sJzumuCXzjgUuh0tXDxL1EowMx6eM=;
        b=mOmvYGs9/0618h9mkFvcnNaYVcsopaZ72ch49Y9QrFQl4GU5yOHXNgzOicn2QpQQ1z
         FIzipIjm9E3qWhCXtbiAqTH7ESrVwM8zFKsETv4Vh3G5+U7mz1plNdG5LCFPX2xn1v9U
         POblZHCMvrVzpkxye7LsdjZUx8AOm/UEr4msvlRMGmpA7gA9cWtp/Wxf2avlKurXl8CR
         AzYxvt7gvK9i8sWStCDkdjDAojSMBt1OD0umcwcvStp4DsUsFoxVkwmXk+Wg7ndWePPA
         H+Uy0V45A8c3DSxwbhcOzBH4a+VAdrOgKAYxD4nn/G+iKdqqbM1ugECUq+99Ka36L4IT
         7Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003098; x=1719607898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBilKbtyKaHgD4sJzumuCXzjgUuh0tXDxL1EowMx6eM=;
        b=gIVbj2E4TgNHredmVN1WTqj6VE0R8elwvxEZOv5eFuz1WfC3kV3AB9B3YNsDQann16
         VNx/QGVFNOAMfPZPGCy7XcNPxrgwDPT2Wo+6zDV7eeDyrbKgxAfEqDyw1y1raLlZvlCu
         0B1BNgn/sZ75Y5oOxf3hqebF7Z1f8ktJStSgOdqrRRkhlpv68hXWrr+nZ324jiWcmILv
         oRQvyj8BCO6F9ELfpr/37aFduTFPSm1tIOMHq56C51sbf8lxe7CoQev0nFA2n9pu6FI0
         +eIU8Ehdqtzb1EjhtWkH24H6RH9DeVCer6E+P9nKB7TLSkRR5O5u13kXTdCho8rZ4w+P
         tzUg==
X-Forwarded-Encrypted: i=1; AJvYcCXM5+wwVPoCu9awXLyVXuPjdplZKU7bhi6I0RN08YnE4p8t3rmeUSelipdJ6WAfDQcPhIyeGGpAmHLF5UfRZi5xnWjPrMFOdxhT
X-Gm-Message-State: AOJu0YwoPLJIcYO9uGz/3EKOfQ/kYdtnzNZIOFufvxo7Iu3E6L2Marx1
	wMu5BI2ZELEycZh4ruqb8HtDruPQgEidwXzlv6I2QWJXZW4JjCITQ9JXjgwYf78=
X-Google-Smtp-Source: AGHT+IHnk+rCUQBAjTY1eOZDYEzFvuFJ00p33gyVBiqrWryWPSi7nD+p40F2ECvVGx8mQu8QqHlakw==
X-Received: by 2002:a05:6808:1381:b0:3d2:283c:e51b with SMTP id 5614622812f47-3d51baeef5emr10287287b6e.52.1719003098305;
        Fri, 21 Jun 2024 13:51:38 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] Documentation: devres: add missing SPI helpers
Date: Fri, 21 Jun 2024 15:51:30 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-1-3f9dcba6e95e@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

A few SPI devm_* helpers were missing from the devres documentation.
This patch adds them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 18caebad7376..a1c17bcae68d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -465,6 +465,8 @@ SPI
   devm_spi_alloc_master()
   devm_spi_alloc_slave()
   devm_spi_register_controller()
+  devm_spi_register_host()
+  devm_spi_register_target()
 
 WATCHDOG
   devm_watchdog_register_device()

-- 
2.45.2



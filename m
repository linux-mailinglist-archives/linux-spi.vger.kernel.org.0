Return-Path: <linux-spi+bounces-1603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1C86EA41
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C51C229F4
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834A3C492;
	Fri,  1 Mar 2024 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zWSmUgla"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAE3C464
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324751; cv=none; b=COVLdIosCtVCy7WuA4tFw35fIDjI5i27QwQJq1yPHvoVY6YLtpci3GyRTeEGXOfHDjpehP40gE3KJDUZ01yXkqJ4gSEZm7uo1vtyx+NL1ob+i8yBDZXDsBFPdvme/AtV9UAHwXqghEZ7YbaJw4BiaRTAb76P7VeBgljAheLzbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324751; c=relaxed/simple;
	bh=x0DFLoC174O3epeySBoaTM35XDoUrTape8KCryCpORc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHp3XMIhmqMpQxluHL0JMAQLm3HnZRFBlfLqJDZgF/p4WNjw8+IqTXLtSxLOSNqDTh6uEdB+KCLBU1vPOSOCsxX6ayAVyx4XpqBIS6Wn0iBGCVLYlY5oXwSoVADb6hWLyq4s26WJHySNB0iqqBL30AxeUU7EOgtYm8jDUXgDvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zWSmUgla; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4953d801bso1470573a34.2
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324748; x=1709929548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2nuq+lCNY6xJUUWqdq+PvBjp+jN2OieX7PRxnI0HEY=;
        b=zWSmUglaqY3cox69vAiQYjcraShWC2ORQdqQil3LL+G8HOVsLCWDDbiAjpYHMpE+Di
         /CwWBquDCZp5XtqUz7CdpbF2HaTjte0PehF7dXTBH2xwsDNkU0miOuiltfp9Gay8Yu5v
         lR8vrMNMdi68lD1kyc2iddAO/IOcaFtcUHs8q442mNWfQkr7aVL31TLYdA1RTOHhYll2
         8cbQvTtkpg5x+Iw+LCOZ4P3D48UFePz+M65OvAEOoW9WNJ5ywQjjmqXWwrRsd9+tvCtJ
         TFBq8HHaqr05UCvg1Iib8Hx0k+/y+1e9f9FFuehRuEAhn9n5s60sVgW8jkO+YPDYwOaa
         2ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324748; x=1709929548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nuq+lCNY6xJUUWqdq+PvBjp+jN2OieX7PRxnI0HEY=;
        b=WgMsZPDj/hJZOJd5TvLDNVMn+LULqlIidbYh1/CkEhmxrlqfwGPMPTrpt4Xht8k04r
         8RdEilpnZhBMYftWaFjWDXlGA/5ESryhOlChgO5de1QD3C+vJ0sCnI9w+Gwyq1I2h5WU
         fgf3KKAPcgjkRT+e63KB3DZhOOeqVqtBOdGuD42GEE0z1/vXknzaP/s9bAqglod5lZYy
         QNFnNbstVgd9uu6+pypQkJ8ACXSnYJ9DgEUvArG6txrcvWQIkq1cEdSeOXDxffLFArrr
         xyvI3Fr0GDt0n1Z3sV1X+K1XIxcUgN19nKnfhyJpbVDlLRpycM+IuXcQdiVbT3ACUr2c
         KdnA==
X-Forwarded-Encrypted: i=1; AJvYcCUHGfnYkr05QKC5rW1B3tUdVOlqNTkIxNtAKDXN5j6qQFHfDNLC7rGvvYt2miKszvJVOPfvUdrD4XwzsUgHKkqI+oHGfIv2OmfC
X-Gm-Message-State: AOJu0Yx6eEOvdLKchwRlE1GjIEZN4pBYglF7nvhLfo80RwyOEZO1RtJh
	W0QdhUJKRgs9H79C+lfCpGjgUyigIn5ZA6rwW5QxwNOPz3XpqOkZhOl1ollgXEw=
X-Google-Smtp-Source: AGHT+IEIRcu0yF7zv3tgmtWOQSxRV+jW5LhwDWLaJSkGdaVRO9G2kgcBsWGngjq/PcjDQAJKwsHWyw==
X-Received: by 2002:a05:6830:12d8:b0:6e4:9af3:5df1 with SMTP id a24-20020a05683012d800b006e49af35df1mr2782874otq.23.1709324748678;
        Fri, 01 Mar 2024 12:25:48 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] spi: axi-spi-engine: small cleanups
Date: Fri,  1 Mar 2024 14:25:17 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This series contains a few small cleanups to the axi-spi-engine driver,
mostly suggested from previous reviews.

---
David Lechner (3):
      spi: axi-spi-engine: remove p from struct spi_engine_message_state
      spi: axi-spi-engine: use __counted_by() attribute
      spi: axi-spi-engine: use struct_size() macro

 drivers/spi/spi-axi-spi-engine.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)
---
base-commit: bf790d87088a04d5f3a4659e04ff2a5a16eca294
change-id: 20240301-mainline-axi-spi-engine-small-cleanups-cd08b51cb6d4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>



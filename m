Return-Path: <linux-spi+bounces-1941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12056881C9D
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF3282AAC
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D74AED6;
	Thu, 21 Mar 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="itLdPHLs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC741E4E
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003791; cv=none; b=am24PFoymA35vsObDQ/u5GisRm0xPTVzUKme7c10mrubTidH3u7rTC46i5VgFjiq4nvwXKnqGHKs/CJHClPh0eJcQ1oCCBFudfTmVMbFKl0eOMViwT2Hu7gB57KFugr23Zlmwp+PEifLLGYNhxUjeD5zJtd+8U0aGoTbJhADa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003791; c=relaxed/simple;
	bh=IgovOM9KUeWENwA/mJE5Ljvl53JZKmY38SkL4KVY3lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lkc2r3Tt3hZdMK9nCdevk/z3gd76qfz5iCLZnz+Fp/9vazNpIzBxEGYwBrvE2acbKMc6ICce+gbLgPdNEUfHnguKSQevLvIsegsG+DBRJfQ3ZxnPTXC5b+IA3XlXA95lGkAL7JkuR7v9IA3pCoVgdenrFlxMmn1tilps1QcJjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=itLdPHLs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609f1f97864so6958467b3.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711003789; x=1711608589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtvNQiaw+2/IaxnmzdGoLxqPTPX+iJkSvUz6nFXt6OU=;
        b=itLdPHLsBisgnP4S6bThB6GjEPn0SIKz4w52YdbgWeHoSF5rQ164J67TVZztHtalS1
         P3hpdmGzzsdTBD5lD9NggZUtTAK2mBIFicSjsswi1eTkiq7T0s70GuqKMyHR0RtrZ8qK
         HzXRhRSpPOwBgfOZ4fd+YpLllbvaBD0HRtcSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003789; x=1711608589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtvNQiaw+2/IaxnmzdGoLxqPTPX+iJkSvUz6nFXt6OU=;
        b=eSTVnVD0O2p4ou8CmM6509p8SYRQ2rRQGttivdK+vI8pzkIE2WbVxO2VlX0l3/W1e/
         Yr25f6d9t1MPZvEq2cm64QyHUBlz/GHog/71IQ8gye1uEjbaBmI7eB9vr5EU0SWaDZxk
         AWjZW2RyJnYwyja0dkker43vZQzVgIA86jBqcxloz52sEpKQXJXlDssDniABKBCPJMue
         nayssNZEwauZkPcoS1P0nh01PnmyT+1kCpfekr2TAfWz93oDqHcMAy/wNwc8dyR6VNlU
         Ty4gO7MQvHYdpTZPNlXh74SjgoZnr/CYlGgs6gVCg9LyGBFYDpnksEFLc1Q+wV/qRD4s
         fNHA==
X-Forwarded-Encrypted: i=1; AJvYcCWswBZdamNEXco7rsu+mVbUoO4ySFVukhPXz2K0iVNS1HUG0m6/MqK63EN9tPmvaSUBgrjSLZMaGpS6JPN3nCsh5oMVgPg62yYE
X-Gm-Message-State: AOJu0Yx3bTF8sBNIU/4WO69l3zf+Ype7QbL7OaTDSNpTyYBdfJ8QUme2
	vc1wqf/pISKF8Q9sxzGp441LpwXRgisFiChfI5n42KcTeNFUu+wPjcieq5618m0A8jnQZAUjEDw
	=
X-Google-Smtp-Source: AGHT+IHWd5hWPmT05m/dMO6abQe1VIjaPIiKOk2TwZu/GsKoXdSkfitV4XwZzfzNFOrPnEs3/o8wrg==
X-Received: by 2002:a05:6a20:4907:b0:1a3:4469:5967 with SMTP id ft7-20020a056a20490700b001a344695967mr7091773pzb.57.1711003407287;
        Wed, 20 Mar 2024 23:43:27 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12874938pfb.51.2024.03.20.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:43:26 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 0/2] Fixes NULL pointer access in spi-mt65xx.c
Date: Thu, 21 Mar 2024 14:41:00 +0800
Message-ID: <20240321064313.1385316-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains two patches for spi-mt65xx.c, both focusing on its
interrupt handler mtk_spi_interrupt().

The first patch is to fix a NULL pointer access in the interrupt
handler, which is first found on a MT8186 Chromebook device when the
system tries to establish host communication with its embedded
controller.

The second one is a decorative clean-up when I'm working on the first
patch, which simply renames a variable to better follow the rest of the
code.
I put this after the first fix because I think that will make
maintainers and users slightly easier to only backport the fix if
needed.

Looking forward to any feedback, thank you.

Regards,
Fei


Fei Shao (2):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
  spi: spi-mt65xx: Rename a variable in interrupt handler

 drivers/spi/spi-mt65xx.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog



Return-Path: <linux-spi+bounces-4202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779B955E78
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB741C20AAB
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B421494BB;
	Sun, 18 Aug 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF0occUN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AF1386C6;
	Sun, 18 Aug 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724004853; cv=none; b=rCZWeNhatEdD5GeGExx5q/7PEu6od9kvkdWUoB8U4Vz5YzFBhVySoT30TIvfBmDcsWYJ//WOnaQA4gDvXqVCe2sLJq41+/JJn2HyFmlISjQFlBft8T5Zf8jyLS7JqFnOt7g90WqXSSjkEkg44clgjJtEw1Hjpoo26MuBZylj3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724004853; c=relaxed/simple;
	bh=XWjrJk+EEOB9b3HIE7zc8YMXgqBMiH/4nusc5+7ewp8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X4VrhUobf7V2lhdJ6mnghVRz/pD2BZiLp/3dxpCCtmvKgbLfTOelf2mIVarmM0tbNIB6/NeCpT4ap7NjxjwwDogaXXZ6onw+RSYmgczx7lVamRK2H6rozViTvQJ9kyGqJ62qC9kQfldH/dwL6YvWiTAJtiSBMXjRoK/c0omKVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF0occUN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fe9cf83c7so20010111cf.0;
        Sun, 18 Aug 2024 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724004851; x=1724609651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lx41hX8slHGqhq4v8T55HkEzecCy+7NRWvJePT1xy54=;
        b=PF0occUN3zTMpYP/zQ6kiKCmNiyiCa1seBP+UaCTvWsCE6/3B22hhtlQY5FmLhLM85
         9zuxgvA/G2wDcW4033NWz6R076Khv9aeMd92cmD5X/ZLP6q2wKHTGIvg2sqyJjzIgd8o
         4FSUd9+0ixIAg5FgTw9NQV21f+nvquaroJ60yGfAQZc0WFIB/71bLh93MhlwbBJ8WRul
         kYS3eVi6BHoopl7m0T8BqqzPD4f8kML4OcR4eSfL7yOev1m4asfzuyCKrQmEOn6WeDeT
         MoRvliSfKnWHsKmO0kInCF+dCqlvd8hVB2QCK50I88Ym7DnBd28DDh4sBhyfg5jpAqVr
         IeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724004851; x=1724609651;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx41hX8slHGqhq4v8T55HkEzecCy+7NRWvJePT1xy54=;
        b=S7j4IHrtqOApMO/6AA8eXcmXjo9u/WJk2UiemImscyVLrcXJN/IwwMn0m0sfJm/pem
         W7suHcLsKkUKWNcZJCirSDqhDzmBpGF/zdorQGRh81YjemZCUWlDPo2viAEVlvRmqXGe
         V6X48N3PcZpyjDSdxa0rFppoHDf8DIQ4eusgn4du1HfLXeXBRWowCn160LM5MESYF94z
         /XBzYiB0ITj1mvyjhCu/M55k1egwqqfEmq7Ytzlz98O6oTJaDDyMCMiAxaHhRqyPvx11
         z0mM4cYT0TS0Mdb9fjGq7V5pFR6FTnxY+QzSrTUI83td/22rWqt3GggylaFJd6EaELEK
         SA/g==
X-Forwarded-Encrypted: i=1; AJvYcCWzyr40jdhNmq1m3M4rSvdf2C4DXkleQdcDMqotXibRUYhPTBKdFoZ5FJuvDcgIYGNAMqboZOdXCIgdfnCAJfuMNRKxUlyNNU6vBs5KD6NDugCBqAnxrjTTZMqXpYhPo2wkCrSzUDne
X-Gm-Message-State: AOJu0YycSf9RXOgIHNk0Axh3LA0pY/H2njJKM8QtdvTOrCqqn2X5yFtn
	7eGbaKKnFxv8VrBSxkNmM2ULZqkouv+rGxdTf2IgcX6VACJqH3OYtSWi5N0p9JXGfSqikFI4CBJ
	hm0+dGcOcWR7U60JKz5F+d5jfJNI=
X-Google-Smtp-Source: AGHT+IEBL625KcD1kpuBiCMK4VjFg/m1u/6ZmbtETY/JKUjKcrCFAc4j1uJJDGmQV/5EKd7mTqAbcleQO/3GhMql7Pg=
X-Received: by 2002:a05:622a:428a:b0:44f:edad:3a23 with SMTP id
 d75a77b69052e-453743a9f1fmr105192001cf.48.1724004851046; Sun, 18 Aug 2024
 11:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vicente Bergas <vicencb@gmail.com>
Date: Sun, 18 Aug 2024 20:13:59 +0200
Message-ID: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
Subject: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,
i am a user of the CONFIG_SPI_SPIDEV device.
It stopped working between 6.8 and 6.10.5.
The SPI bus itself reports no errors to userspace, but no devices
appear connected to the bus.
The platform used is RK3328.
The only spi-related message in dmesg is:
rockchip-spi ff190000.spi: Runtime PM usage count underflow!

Please, can somebody review this issue?

Regards,
  Vicente.


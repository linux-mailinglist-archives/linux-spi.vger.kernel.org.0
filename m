Return-Path: <linux-spi+bounces-6972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C144A49145
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 07:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E1016FB90
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69C155A25;
	Fri, 28 Feb 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5F8gwq+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AD849C
	for <linux-spi@vger.kernel.org>; Fri, 28 Feb 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722452; cv=none; b=pKGP5psl815N2vYya+6ujTgY3dx6Rtj84tpHRfVWPQ6oRlgggb4TZ9l1T3i9eet1vZ6OIfTH+yY9jII2NhGEifts5RVd8NJIPlwZoIWghNP0OAx9tffLEC07z0VKMKkiZtwBVi5CHiSAM9Ax2hiAMYxF/En9JmEK6W9hMfu7IlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722452; c=relaxed/simple;
	bh=twi/yzpdXsZjs7Pe1CdQSGFbeIRq05yQQFooB/+9mvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j1YzfFnaJ+eBNgkaHqdPEwk5hxFYcgHKxkak9fJlyLG/fp7sIVFOUiyzbPrrOtY0dHUFBrTknOAaOeSmrN7f6trMj2pw68Baxea1dAjjN2Vxbveb7Ry9P64Y6AWCnnumdjUix9euQhnAqUDNQCQJKppzqcnHJZuZKDmbKQ+qlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5F8gwq+; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso691743241.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Feb 2025 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740722450; x=1741327250; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llT+ginst054rhLhA6/yosLb6bykmkgNldbu3QbBuo4=;
        b=Z5F8gwq+NzZApblDomq3JlGuetPjKL/FDhTPc9AbJP2ssuws74fwcon9K3bVA2VoZB
         aeMZt9vq5fJzA74y8gD3osDERFEps5lDO+GMdQLU5CeqGPF41p5mjPWEcSEFmny1ZRic
         pkz10q4g4ATLF5SndJyq2S3tw6NKTJByrMQOSaO29dwTc1R0gCI7IJDFYM+u6a+6YEGF
         9powV1vkbXTrnhfzHU2+LRa5Q89dnRMKwvEPLq2u8Cxa9e93tuIhTxNSLueb1Kzcsg8r
         +BMS+ZPThctyLLOq7pxiq/eMznoUjaTNMLICA2ydUjvNw97Cls9XLgjrFeDQFkGOMXKU
         +xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722450; x=1741327250;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llT+ginst054rhLhA6/yosLb6bykmkgNldbu3QbBuo4=;
        b=K0OL0ku8Zp9N/R5n8tos09s449w5RNhVXD7UrZEPniOx6DEcjMmbgvU8r7hlHrZdfm
         hqFHOp//xIbUilQwPEmpQlFa8DbMoJ01/mDjF1NUjR2pdBErBKpiSbvJ5ue3AV/vFLrV
         mPo+fNUjOAX4lPLJc8orH+gF8iBKEgHajo/PeqefSSsvrKNuiD56GkcIKX0h8ARWKXGQ
         TWEYtFn2z8oUSDnzIJJ/uTj4ZV6HD1s4OqBD8tMuxErQR8EzWN0KqvJNFR4/3ZaduZH/
         P6mh15MwHiFr61gNGoV95kC22PeLY7nH1I9Yd/M0HuAES+a/DNkLb8cp2Dqyq8nGLeZO
         m0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUc9mcY7OO3Ua2nAYTLVv0Ta/9Ym3fV5GadtxmubITrnxN/i4l1/OVIgObl1a7RT0j0Kw2GeWt/6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38o0z3/odPRhWEwooX4psbwKfJi6TzCYgjsn4f6s32QcnKN2j
	yLsO0duOhzWydsCJnNeC70BKWI4jS9dt56h1jSH3HMc94i0lMSNAm39szN3gJQlbN8YvA1qAIAS
	ZCnhhje7EbSXkF8JUeI3NO0+2lOcRwg==
X-Gm-Gg: ASbGncuIOQpcNUlxF8dUVb8S7UxBSlATu0Woh2vzWoyknW/2juXfGoVCur28MN2yiEJ
	67eSz+Cij/P5EmCFOKCwnxWsFeHitKRllerIW+Cn9NEjwcq8Man5/NZ6VRiuZl2kHJuiMmByB1s
	Mmzy4MTo0S2JI5D5j5JfZ7FIqQ/GUgdEFDfxQxvDU=
X-Google-Smtp-Source: AGHT+IEw3bOzxz+D4RRtXdGLVVCwq4xoxXyDIF4NB0Jj9uEuWuXKI6wXo8OwXwzRYdzY3dnSkRyPaa+qCyosS6Apfys=
X-Received: by 2002:a05:6102:1485:b0:4bb:ecb9:b34d with SMTP id
 ada2fe7eead31-4c044eda3b5mr1797529137.18.1740722449741; Thu, 27 Feb 2025
 22:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD-cv=PxghRoD12wiJL0=e30OMqT0S-Wbw-yt-ubVP45F-tz6g@mail.gmail.com>
In-Reply-To: <CAD-cv=PxghRoD12wiJL0=e30OMqT0S-Wbw-yt-ubVP45F-tz6g@mail.gmail.com>
From: Andrea Tessadri <tessadriandrea@gmail.com>
Date: Fri, 28 Feb 2025 07:00:40 +0100
X-Gm-Features: AQ5f1JoJpvY2GAXSA9MrcbqgtJzLxFpD9LvqWun8N0BYf_HshljWMHboV9xC77o
Message-ID: <CAD-cv=PqGB455jgVunJQ5x0brGyG9zz6NJaBt+7Qd+3UpY0eug@mail.gmail.com>
Subject: Fwd: Adding circular buffer capability to spi-imx.c
To: imx@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,
   I work with a IMX8 PLUS EVK and I need to receive a high rate data
flow via SPI from a real-time external microcontroller clocked by an
ADC capture.

My idea was to extend the spi-imx.c driver to add capability to use
dma_prep_cyclic with iMX8 powerful SDMA.

So, in this case Linux will be spi slave (the real time micro is
master) but I wouldn't like to use PIO mode since I can control spi
master to send data 4 bytes aligned to fit DMA alignment requirements.

I am stuck with implementation:
1) to change transfer_one is not the good way because I don't need
pump messages from SPI subsystem, I just need DMA doing the job and to
follow the transfer with a callback triggered by SDMA part every
"period len"

2) to add the transfer function (deprecated) to use spi_async is a
possibility but I don't know how to pass the period len info: if I
consider to pass a message with several transfers I have to check that
every buffer in a transfer has the same size

3) to use transfer function with a spi message and several transfers
(one for each period of a circular buffer) prevents me to use
dma_prep_cyclic that works on a single buffer (then descriptors inside
dma_prep_cyclic will split the buffer in N periods)

Should I go for using setup and cleanup that are now empty ?
In this case I can consider:
A) with setup I can pass into spi_device the information about a
circular buffer allocated by a protocol driver and also I can add a
callback to be triggered by DMA
B) with cleanup I could stop the DMA transfer when needed

Anyway, setup and cleanup shouldn't start or stop the spi transfer and
this is why I am puzzling to get the proper solution.

Thank you in advance

  Andrea Tessadri
  (Italy)


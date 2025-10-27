Return-Path: <linux-spi+bounces-10847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB32C0D6FB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B34189D3FB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E43009F1;
	Mon, 27 Oct 2025 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaZZ4nY+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349A2F6904
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567205; cv=none; b=rF+RR9YNHj6uNbFQzheE9WZMoaK6moQ/o4r9Db/ZzhYKbk9Cxg19nm0BHhJzmZQ/HtRW/0f1ISbehnO3p6wzNDeoz8XkfUCmNAnZbYmhTrLP/q+KYYcWLeAIELUoruYxMwoswvPlgIR2jQFQ+aq92YfOSJhdxsuz+cEEJs1zyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567205; c=relaxed/simple;
	bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Grj8BaCKq9mVW5KYhRjAhHbgGmYVKvXXIq4ZG1DJlpUL953eWUsB9yl4fEXHj3nhZHdCLuLtFX2ekmOlO7JPO4M4x2HWGc9gdSJryfqnO5V9TV9evgN7rqLIHXnfvAul/wjSa/GhqsI31i+p35fdu2sSvsYfw35HDw2JmkTogZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaZZ4nY+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378d50162e0so53070851fa.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761567200; x=1762172000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
        b=KaZZ4nY+3TnvvxoHgQrbVu9+tZEK3027bFKCQ+9NiUrlxoI6bv5LnB3mMwAn7cQzoQ
         2vJVHuX26IOO/QdVlq7o92Zo1/E5atx2HzFrIpVjfoPmPiBOUgb+n/8OcO8gg7fubEea
         lokvXN0nFDrFDD03uybyQ/CuRD5zj2VK5vSieleW0j2QwyPXqUYaAkZ8LNDWAuYcJ696
         ntoUG+Ajo9ODZbDftUanUFwg16vPUQPSXFqCpQuaHRV9ay5YQu8BCTyhbw6uJF2xHMlY
         KeK0F3khxW9ePwxVjOW8sM5kytgklboAKlM9aE8nykL0MmtwADPbFOJBVaz+HAeDFE8S
         hiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567200; x=1762172000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
        b=xD26nv8oBkGCg2CSuK5OB7qPcMyHLIxUo2TDgFkTPH7aUG/uAVuGlDJANkPcR1FAgL
         PEdfYW7WfkuZOfvR0mGeIsdrURBEx9x8JVmBUIQg2ASK90KOf4AnicsJHu20/zil5xN7
         xeYUe4YgLE/HqizKHBH/J+BKThT8VxQaqqc1wM3ma62qVSV+rgq7zHz5DGn8t7MLd0ud
         1nFaMI2oxwb8tdpuoc6EWzI+rLRplKM9fWwLVMcUOAwPaynqgjGnb3o7To+M8CM//elZ
         QgJ0A9YZ30SHkorKsYouxqrOGr7mZc3JgJjQbp41G6mS/tfQTjuOSR6Ts3lyGCsFwFdv
         WejQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk2tjfaRnILNEG9XivvML21chTDwfRfivc27sch40YTBrskTMHM0hcsyq0os1NzRLLFIS+fNAhZ2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVmw674Q+RnBwO1QWr+FLDzzZSLU8smToki05NqVBW3WW4bgN
	ch2dlot5mYaUknq12dNaenHt6DK0MgoE6hYHGEF7zzM3sgLUqsr6+dY/ew9IGp3dmYhGccqT4Hz
	5D711b0Y1zBvG+AQZqY+Xv33LatgOTnbJUwrE
X-Gm-Gg: ASbGncvWNeDLhW+1nnSkIuBbzM2t1rlf6GAnH93Nkvn10ZgJ+Qw6/gYmGd34GVDKuev
	wOGxCkS33kAR99MDkiVCa+nYzbLZexh/REAK44pzjSXiVIPmwjeONi8/Z0Yr5/rd2g9F+kkBFhs
	1J9WrKqyBORe4lQ/EiRIFFNiatVqGJbSvoDJEVbc+MTXheMwOCDwD8mhuxSG5xD+uHJdihpdIGS
	GYRv/hT6zKMfvXUeUUZuMv3A/DISaJptUAUQdikSgzy+wqfYKJ0n9SCMwV4sjeIyImoIAnnNxa2
	RHHfhhC4tgnRlX9lMmNn1zNUcYA=
X-Google-Smtp-Source: AGHT+IFFfKN+siPeEk510LCYlRaBchkOKpAuwWhbm3bWGz56uyRA9KKdEl3XVRQWOc57AU14oMs/9BA7nmAnn1K3lvg=
X-Received: by 2002:a2e:be09:0:b0:372:8c4b:8065 with SMTP id
 38308e7fff4ca-37797a2cb95mr104193231fa.26.1761567199979; Mon, 27 Oct 2025
 05:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027110406.543370-1-carlos.song@nxp.com>
In-Reply-To: <20251027110406.543370-1-carlos.song@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Oct 2025 09:13:08 -0300
X-Gm-Features: AWmQ_bkk_6yx_Hjl3n22lrPiupz3ujJbjohrrhluMrC5cpjjXVzvvJEhkBoNxhs
Message-ID: <CAOMZO5DM5NyGdyz4_6WF7qcsMmjAdQvfK0AKxZprUfhC=882pg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: imx: keep dma request disabled before dma
 transfer setup
To: carlos.song@nxp.com
Cc: frank.li@nxp.com, broonie@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:04=E2=80=AFAM <carlos.song@nxp.com> wrote:
>
> From: Robin Gong <yibin.gong@nxp.com>
>
> Due to a hardware limitation on SDMA event enable (ENBLn), the DMA reques=
t
> must remain disabled until the DMA transfer setup is complete.
>
> Refer SDMA 2.6.28 Channel Enable RAM (SDMAARMx_CHNENBLn) section:
>
> "
> It is thus essential for the Arm platform to program them before any DMA
> request is triggered to the SDMA, otherwise an unpredictable combination
> of channels may be started.
> "
>
> SDMA hardware configuration is postponed to transfer phase, so enabling
> the DMA request too early may cause unpredictable channel activation.
> Then keep dma request disabled before dma transfer setup.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Should this contain a Fixes tag?


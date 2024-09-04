Return-Path: <linux-spi+bounces-4637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A796C611
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 20:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298B91F23B4F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4711E1A17;
	Wed,  4 Sep 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EddMyWSr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252336E619
	for <linux-spi@vger.kernel.org>; Wed,  4 Sep 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473571; cv=none; b=CoKtLT2SErFXnK+AZ+E/512hrTJ9pGd/jPnkjP3rN12iVWerdnR+cZI+C20/K1RA3bujspLHEhcfu0psyXTRdR04aIAFUFobQ4fUN2D5YRiPDr1QAHPKRDSTbGkuHG7R543/MGVHVcI0H+Iu+6hUVr7MFgELheSFgbtEyonTtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473571; c=relaxed/simple;
	bh=EDc4r4+xRzvXVV3HSRmgmHOsfqz56ufDfhO9wjnGKWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/5H4AgvYD/ibiUyaKQjIVUElIuS1PqMtBtE2/A1TQtFYgqXMLH5PFDWM06aVaa3DoiyjdV2FL/olmjteqgeamC7tIpjniriqVQspstaLZvQrT053zS8XfFZScwyNDxv7aNO/C1vzygjbpcSwZc1ooKGHnGFUVTzJAKmjZcy/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EddMyWSr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-456825b4314so9250261cf.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Sep 2024 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725473568; x=1726078368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9qNms9IqvULTHZLxrO4XAA8Z7D/Rr+IHxtM8XyaHUA=;
        b=EddMyWSrpODvNg9P/qhYGDpf0M14yNpq+qjjvzl7zFV5a0qiIOoZff41UReCfy5hGa
         SSZwN5e/0fi+t+IlfIEdMjzEkOFE3PJ+Gn32wG2kYNxqbqiNyw5Imo/CRP2PvUFAdtM5
         v8fgWCfoKCt8h1mJWjfUdoDQdmka1ipHohOD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473568; x=1726078368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9qNms9IqvULTHZLxrO4XAA8Z7D/Rr+IHxtM8XyaHUA=;
        b=nCTyzZnRDtqltNXO0/0EQAk7PMfCK2fw9x6uiKnIpc9w6Y8k8Fre1ZztqL+VLfJZDh
         kp6pNeD4hkVF7DpEDIHo834UefouBnO5GWHwFasBTbQJnzBUbK3meRSfYjQbLWVnFQy6
         FveXmr6mP1SEs9NJ+e+IrRC7FpLFJRbZNJ5qw0s8uxyPnrE6/AZajmb8C8RtHP8+WFsi
         AtgdPbgOhww1RPr0iJ4nVuC5tJ0UckS2nvIzWH2okWUCVuImyA8zYcDpDUf3MG2dZawk
         zd2R9KfLzDP7zrjbAR/b7x7Ov0wZJ36ztJoWgbVMCnQsM3vZS3IclmLqrP5joFkrKvWN
         yCZg==
X-Forwarded-Encrypted: i=1; AJvYcCX3O6zdcQk7mJ20Y3RlME57NmCN0BSHRkFaFkJRqTISGbV9Ovi/ORf6sTVT8xeKn0EbjeK/aVG0T8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcbO+LwkDA2gSQowDJNFU+n3kCdEonZLRZXXW616PciczHq3A
	9qbvftGZ9i7lf4F+/2YQiLE8uDQLAqlt7Xlgfjc0alhKPjlILIjsGpk3WFXNmNPg+LgCsFU1Cl8
	=
X-Google-Smtp-Source: AGHT+IGuDJR1Yz9UsH1zZrnsq7iBK0eOGYHerCvR3IuVVHM6L6w5osj7CThQMzHJucqAJsVNBUs7eQ==
X-Received: by 2002:ac8:7e92:0:b0:453:5f34:1d1b with SMTP id d75a77b69052e-457f8bf4ecbmr40963351cf.18.1725473568578;
        Wed, 04 Sep 2024 11:12:48 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db2c2bsm355171cf.70.2024.09.04.11.12.47
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:12:47 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so9389846d6.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Sep 2024 11:12:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcdHQuu0Zph4qw8GFMr4kisiB7zyPZmA/NIjBhi2i+jREDPE/wYX+9rcwemvd7kbj2amqzsPYmQRE=@vger.kernel.org
X-Received: by 2002:a05:6214:490a:b0:6c3:3efe:3fac with SMTP id
 6a1803df08f44-6c518de919amr63889426d6.3.1725473567119; Wed, 04 Sep 2024
 11:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904021943.2076343-1-ruanjinjie@huawei.com> <20240904021943.2076343-3-ruanjinjie@huawei.com>
In-Reply-To: <20240904021943.2076343-3-ruanjinjie@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 11:12:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vdcv4aSNGBOPoLELfTBW_0QYn2mnO0upmuHX=cTpZbLg@mail.gmail.com>
Message-ID: <CAD=FV=Vdcv4aSNGBOPoLELfTBW_0QYn2mnO0upmuHX=cTpZbLg@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] spi: geni-qcom: Undo runtime PM changes at
 driver exit time
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 3, 2024 at 7:11=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> initially enabled pm_runtime with devm_pm_runtime_enable()
> (which handles it for you).
>
> Hence, switch to devm_pm_runtime_enable() to fix it.
>
> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250=
 ms")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Given that this is a "Fix" it should be the first patch in the series.
Your ${SUBJECT} should also not contain "-next". Not only is that not
a convention for the SPI tree (that I'm aware of) it also is probably
wrong since fixes should usually get queued to an earlier tree...

As per my response to patch #1 in your series, the pm_runtime fix also
needs to be first in your series for correctness.


> @@ -1153,10 +1153,9 @@ static int spi_geni_probe(struct platform_device *=
pdev)
>                 goto spi_geni_release_dma;
>
>         return 0;
> +

Unrelated whitespace change?


-Doug


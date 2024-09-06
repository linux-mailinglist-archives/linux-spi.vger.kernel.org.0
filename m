Return-Path: <linux-spi+bounces-4711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF696E86F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DBC1F2497F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547942E822;
	Fri,  6 Sep 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4kw9+H4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855CA41
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594738; cv=none; b=mwZ78p/iqPMbDlmAZME5q2QeZQ1ziBzEqf2dAl9re4LPLPJfKmxnwE6+UFO/VLDQb7zpDUUzvbYHJ/9osdS6RfXA64d0avIvNdw3YX4Qm27F70q5jbal1mvOo6VdQj6NkSf1WM5piWuKvZnx9dhJ9ZIXPjEmjkY6DumwOJy/6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594738; c=relaxed/simple;
	bh=w74Sil1Hza/L2EJKOCLxnglWbDMuX3ZxVLqw//w+2bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR6X0fRMkUf2BPySJlOdLxaUbH2gZh8QfNaMklgv0Jl0ti06JC7wgADz/54M+qZdbKeAuLYAXpMngUVO1ms+Y8BR6bHG3j/ruWQGOOjUPTE9pFrX4u6092oOQ2calvjO/DlB70olv5/uQx2F13xjKFILbcUL1GGQO9Z8nollGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4kw9+H4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so1878093276.3
        for <linux-spi@vger.kernel.org>; Thu, 05 Sep 2024 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725594734; x=1726199534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1RCQi0PIE56EUCdYz3+gRkrVIWfG7yP7PnLRZb+nwgs=;
        b=r4kw9+H4kSYpFl4+cdCESNuTKWXo+mZFtKj2pwJc0kabkd7PT++FN1lcXUs8Bka+kN
         CvwLWoBlC7TLf7D0mlkZuOl9bZaP7dN2/KooUcfQkDGtw93/spiexzDrnXyXL5IPj3Xc
         NfzmjoSyjLuc4TYbfOuNkIzm48TKMgYrFhwWj8dddJrPECQ7u6NHeSNuC6JwddliDfto
         c0FRpknsYNiyELFehETHsnAN2t9vV06BKqE2TEI/pTbRhp1UNzr0Eq4yAfya0g6uBsbJ
         Hlx/r6lV9FFAdwBTafgSS9Sy5mR26qxXboUUK0bdHufIOCWrjdyUUcEhFas9Ni2VjPEz
         xfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725594734; x=1726199534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RCQi0PIE56EUCdYz3+gRkrVIWfG7yP7PnLRZb+nwgs=;
        b=C5I2QMIR3DSSj43ee7jYUUu4RUYiZmX+BXaIXv9AIZWUwIr3jR+hLsANFO1UP03Eba
         BjcoE/5mEftJAmlK4euJ7hH9yPoLAiTaNtBADqhqL4dldXUYke+w0JBYrRovXGX9ByoG
         8u+lUZvdteRgVQxcQ0OU8BUH9jkdp+RgPt7Z4UrQZHxygij8RYYf6oeiu+w1s6Cbt8Cq
         RG78x4WNbjH/0cey80xMOWWhjE7ojNv6Hjn345Iri7y5e+COEKIKKZrCui485QfRZn/y
         K3l9kaNQ2XhB/KIaJt3GXh6eX7ir/GkwzfKHxvCa+poysAwF/NSQk3Y1nU1Q6B9q/s/B
         7oZA==
X-Forwarded-Encrypted: i=1; AJvYcCWOGXolsePfiTgFg/8Tpmm9g/eNBHZOhjx2hTp8XXHnuUJn0/fz19nvPLXlW5NowVjeIDPlA0tH3IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyDapmY/h/IIXfX/yDL9oyB055AYbnoEqSHV2C7EFM+2iT45h
	TsnFgvtJdoja3+iyNIBfNZaIyIaOS3ctfdKqrQx0Pkkisj80+7/6ljtc2Kqujo+JC3iii1LuCCJ
	jhhNFyJED7UP9WJAsE7iSwPNLGtKkmX72cnv5ig==
X-Google-Smtp-Source: AGHT+IHHkjj6ex/6bj+w+QkI2FJSutXeFRzTpu2oHxz5DqhCjDCgGAhRDDIxCGWDRZiI+9qUzFbuhu4ZF8Z4+jpdXQM=
X-Received: by 2002:a05:690c:6689:b0:618:2381:2404 with SMTP id
 00721157ae682-6db452d8321mr15826547b3.44.1725594733952; Thu, 05 Sep 2024
 20:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
 <20240906031345.1052241-3-ruanjinjie@huawei.com> <hnos3f34ejabyw2yxtpxifskhklunvnufgsuilghjeuzipqkxi@udw5xfeum37a>
 <050a6434-00f9-4bba-a122-52c3a23fcf70@huawei.com> <CAA8EJpod2OzNEoquSGuJXLUx8-r+J0_YjPzv5pFDFHum9siisQ@mail.gmail.com>
 <3d48b7c3-6dba-b113-9207-f3daa874253e@huawei.com> <CAA8EJppbuMGjo3PHBnmHF5yXFOBUon50ZSKKzWFqGs3qgFmR3g@mail.gmail.com>
 <a314d448-abb7-1a9c-5c45-7fce9aa69362@huawei.com>
In-Reply-To: <a314d448-abb7-1a9c-5c45-7fce9aa69362@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 6 Sep 2024 06:52:02 +0300
Message-ID: <CAA8EJprUPLfzwfJCgeWJ_G4QYKmG=Y304hmFxBZJOhMWxt18dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Fix missing undo runtime PM
 changes at driver exit time
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, vkoul@kernel.org, akashast@codeaurora.org, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 06:51, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/9/6 11:43, Dmitry Baryshkov wrote:
> > On Fri, 6 Sept 2024 at 06:41, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2024/9/6 11:36, Dmitry Baryshkov wrote:
> >>> On Fri, 6 Sept 2024 at 06:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/9/6 11:15, Dmitry Baryshkov wrote:
> >>>>> On Fri, Sep 06, 2024 at 11:13:45AM GMT, Jinjie Ruan wrote:
> >>>>>> It's important to undo pm_runtime_use_autosuspend() with
> >>>>>> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> >>>>>> initially enabled pm_runtime with devm_pm_runtime_enable()
> >>>>>> (which handles it for you).
> >>>>>>
> >>>>>> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
> >>>>>> to fix it.
> >>>>>>
> >>>>>> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
> >>>>>> ---
> >>>>>> v2:
> >>>>>> - Fix it directly instead of use devm_pm_runtime_enable().
> >>>>>
> >>>>> Why?
> >>>>
> >>>> The devm* sequence will have some problem, which will not consistent
> >>>> with the former.
> >>>>
> >>>> Link:
> >>>> https://lore.kernel.org/all/CAD=FV=VyDk-e2KNiuiBcACFAdrQmihOH6X6BSpGB+T1MsgsiKw@mail.gmail.com/
> >>>
> >>> That comment was for devm_request_irq(), not devm_pm_runtime_enable().
> >>
> >>
> >> In the very least, ** parch #2 needs to come before this one and that
> >> would help, but it won't fix everything **. Specifically in order to
> >> keep the order proper you'll need to use devm_add_action_or_reset() to
> >> "devm-ize" the freeing of the DMA channels.
> >
> > This is patch #2. so I don't understand your comment. Moreover you
> > don't have to use devm for each and every possible item. However I
> > think it makes sense for pm_runtime in this case.
>
> You are right, only use devm_pm_runtime_enable() here, there is no
> change for the resource release sequence, but I have a cleanup patch
> ready to replace all these with devm*, which depends on the 2 fix patch.

You can use the devm_pm_runtime_enable() here and land the rest of the
cleanups afterwards.

>
> >
> >>
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> ---
> >>>>>>  drivers/spi/spi-geni-qcom.c | 2 ++
> >>>>>>  1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> >>>>>> index fc2819effe2d..38857edbc785 100644
> >>>>>> --- a/drivers/spi/spi-geni-qcom.c
> >>>>>> +++ b/drivers/spi/spi-geni-qcom.c
> >>>>>> @@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_device *pdev)
> >>>>>>  spi_geni_release_dma:
> >>>>>>      spi_geni_release_dma_chan(mas);
> >>>>>>  spi_geni_probe_runtime_disable:
> >>>>>> +    pm_runtime_dont_use_autosuspend(dev);
> >>>>>>      pm_runtime_disable(dev);
> >>>>>>      return ret;
> >>>>>>  }
> >>>>>> @@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platform_device *pdev)
> >>>>>>
> >>>>>>      spi_geni_release_dma_chan(mas);
> >>>>>>
> >>>>>> +    pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>>>>>      pm_runtime_disable(&pdev->dev);
> >>>>>>  }
> >>>>>>
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
> >>>>>
> >>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry


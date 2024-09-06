Return-Path: <linux-spi+bounces-4713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883996E880
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 06:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9659F1C227CB
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293703D551;
	Fri,  6 Sep 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N92XCken"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E683EA71
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595410; cv=none; b=fofcKgp94T1xv88A03nX/cPCWV1Ne1b8bT6c7fXok5juBAy4tF0T+jdT/J+DFfsfI90qd0XSS4Ff8H/0QLkAEWixJEtqDOnLrbtsaUuscKftFxE7V/w2wqjXEpAhadDMjSz1M6zpqdAabAxtUUsHD8+wIPyAA+kGRu5eJ7uNMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595410; c=relaxed/simple;
	bh=qXXSu1Vc9cXFXzrZGOjpwaURyo+Nk03TGojHs7b/mDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu5M18UMIcSB3fm8FbY88TfNXb1cF1bMR+XPHpbyFZA3VCt8tj7Sxe11LQCqjhUtItv2R3/Hb0lPjyhUBzpHnvOLVakMmpBo47JdTBAa2KmHD2Exf9cf58DUXCTLlXRH3/tJj9hBzQ1mQ7IEEGwZsqKaw3HQ8YbqK3GTTYb5AFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N92XCken; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-68518bc1407so17619177b3.2
        for <linux-spi@vger.kernel.org>; Thu, 05 Sep 2024 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725595407; x=1726200207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXilLr5xpfJZ/63iXCaTCEtEkm5OQlVtWAhxdWKNmkM=;
        b=N92XCkenhP4ilRyK69tEdl2HBa1W80TXa4pLeCWQS5prFT6IuzibaQ1PvujUe2Nimw
         iInBK8t0RVb6WsrhveRqoJI3socX4gWrn9C9VEgIhOtNEYNFYb2AVIrFB1tJx/Y1QFaB
         dA7gzc0RfbLF7SCixcb7fcHlCzCJK4ZCuxYzmaEKpp/3i7qeFZeJ4ZQvrU8o+/DXgA9b
         ju49uqHrf2CMDPFlDfyyKT4DMOf7brvV90lpTGCs2raxRQmc07sVazDlrAYMQasx3Kzv
         fi87XoH24pw9kauOr7nMm3CFJlMFB/ESW0CZF9vV4PNBaVDdRG+PN4RS0+ZoqAcXfvxY
         IixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725595407; x=1726200207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXilLr5xpfJZ/63iXCaTCEtEkm5OQlVtWAhxdWKNmkM=;
        b=a9//MJjKdcfjA+WwRmAELmURyL381RSUXELAVw5fRyf6LN9I7IfCp4JLRq9qzIrC1z
         XmJsWs5+Pucrqk/blQL2x7AfAs5jL82zXm/QEyZ0iHnndy8JPC/XSmeeb0MJgcpJgEmM
         5wu5ZuovqZWHESMlIJhm5K8LiipqetH2XAZNMt7bCaFJ/RCpPsgGxXAziKHxCRN/l290
         mtXi6303QFwcCZv77dgursln8QemLA0lwYqnFnRurCwl06oefr6whMzi0HTgt/hxPwF9
         hDdUcG2Vd4//wV0zJc+u44UGjirLoSfylAdhzTZRfIQgVgwR2C5eYNsCcl/5fOA0Z+60
         4inQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDA+XER3N3aj7aa7oo58AyujfHeSd6bMtMMquvJxs1SiPF5/WfgzmvZ2cNTLVR2zo42sr5H95nWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3BaxdbQxWL7u0vwc2FZGhKWzC+xam91/KywOzXFjfTodpLUj
	1lkdDwLNY0mEagHng9Yxs6OENBOjseS6SlKBjyzjGQAb385zcjX5yBw1IVyGj7eWFxnbJeOw/O7
	A241E0k0rIpdJMYJGe/fgf6E8/2uytXgXTtzcV0nBzx4BcRRglWI=
X-Google-Smtp-Source: AGHT+IGmlHdRNCQjKYTWJnQANrqVoyd3VpU1ZmVCSivdF3iIAR+pICOQ076PBfpw5MihHBR44fkfpxcHaLFFHaNeEC4=
X-Received: by 2002:a05:690c:c12:b0:6b8:d8a2:7aa8 with SMTP id
 00721157ae682-6db44f2aa8dmr16459117b3.23.1725595407176; Thu, 05 Sep 2024
 21:03:27 -0700 (PDT)
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
 <a314d448-abb7-1a9c-5c45-7fce9aa69362@huawei.com> <CAA8EJprUPLfzwfJCgeWJ_G4QYKmG=Y304hmFxBZJOhMWxt18dQ@mail.gmail.com>
 <6bc7fa5e-ab59-996c-905f-7448d3090290@huawei.com>
In-Reply-To: <6bc7fa5e-ab59-996c-905f-7448d3090290@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 6 Sep 2024 07:03:16 +0300
Message-ID: <CAA8EJpr3YG-zdNn0yur0UAWCppLUH3hE4xugjj6CyE2=hksLYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Fix missing undo runtime PM
 changes at driver exit time
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, vkoul@kernel.org, akashast@codeaurora.org, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sept 2024 at 07:02, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/9/6 11:52, Dmitry Baryshkov wrote:
> > On Fri, 6 Sept 2024 at 06:51, Jinjie Ruan <ruanjinjie@huawei.com> wrote=
:
> >>
> >>
> >>
> >> On 2024/9/6 11:43, Dmitry Baryshkov wrote:
> >>> On Fri, 6 Sept 2024 at 06:41, Jinjie Ruan <ruanjinjie@huawei.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/9/6 11:36, Dmitry Baryshkov wrote:
> >>>>> On Fri, 6 Sept 2024 at 06:31, Jinjie Ruan <ruanjinjie@huawei.com> w=
rote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2024/9/6 11:15, Dmitry Baryshkov wrote:
> >>>>>>> On Fri, Sep 06, 2024 at 11:13:45AM GMT, Jinjie Ruan wrote:
> >>>>>>>> It's important to undo pm_runtime_use_autosuspend() with
> >>>>>>>> pm_runtime_dont_use_autosuspend() at driver exit time unless dri=
ver
> >>>>>>>> initially enabled pm_runtime with devm_pm_runtime_enable()
> >>>>>>>> (which handles it for you).
> >>>>>>>>
> >>>>>>>> Hence, call pm_runtime_dont_use_autosuspend() at driver exit tim=
e
> >>>>>>>> to fix it.
> >>>>>>>>
> >>>>>>>> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend del=
ay of 250 ms")
> >>>>>>>> ---
> >>>>>>>> v2:
> >>>>>>>> - Fix it directly instead of use devm_pm_runtime_enable().
> >>>>>>>
> >>>>>>> Why?
> >>>>>>
> >>>>>> The devm* sequence will have some problem, which will not consiste=
nt
> >>>>>> with the former.
> >>>>>>
> >>>>>> Link:
> >>>>>> https://lore.kernel.org/all/CAD=3DFV=3DVyDk-e2KNiuiBcACFAdrQmihOH6=
X6BSpGB+T1MsgsiKw@mail.gmail.com/
> >>>>>
> >>>>> That comment was for devm_request_irq(), not devm_pm_runtime_enable=
().
> >>>>
> >>>>
> >>>> In the very least, ** parch #2 needs to come before this one and tha=
t
> >>>> would help, but it won't fix everything **. Specifically in order to
> >>>> keep the order proper you'll need to use devm_add_action_or_reset() =
to
> >>>> "devm-ize" the freeing of the DMA channels.
> >>>
> >>> This is patch #2. so I don't understand your comment. Moreover you
> >>> don't have to use devm for each and every possible item. However I
> >>> think it makes sense for pm_runtime in this case.
> >>
> >> You are right, only use devm_pm_runtime_enable() here, there is no
> >> change for the resource release sequence, but I have a cleanup patch
> >> ready to replace all these with devm*, which depends on the 2 fix patc=
h.
> >
> > You can use the devm_pm_runtime_enable() here and land the rest of the
> > cleanups afterwards.
>
> But Doug suggest that the bug fix patch should not contain "-next", but
> the cleanup patch is "-next", which let me split them =F0=9F=A4=A3

Using devm_pm_runtime_enable() is a bugfix too, if done properly.

>
> >
> >>
> >>>
> >>>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> ---
> >>>>>>>>  drivers/spi/spi-geni-qcom.c | 2 ++
> >>>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-=
qcom.c
> >>>>>>>> index fc2819effe2d..38857edbc785 100644
> >>>>>>>> --- a/drivers/spi/spi-geni-qcom.c
> >>>>>>>> +++ b/drivers/spi/spi-geni-qcom.c
> >>>>>>>> @@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_=
device *pdev)
> >>>>>>>>  spi_geni_release_dma:
> >>>>>>>>      spi_geni_release_dma_chan(mas);
> >>>>>>>>  spi_geni_probe_runtime_disable:
> >>>>>>>> +    pm_runtime_dont_use_autosuspend(dev);
> >>>>>>>>      pm_runtime_disable(dev);
> >>>>>>>>      return ret;
> >>>>>>>>  }
> >>>>>>>> @@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platfor=
m_device *pdev)
> >>>>>>>>
> >>>>>>>>      spi_geni_release_dma_chan(mas);
> >>>>>>>>
> >>>>>>>> +    pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>>>>>>>      pm_runtime_disable(&pdev->dev);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.34.1
> >>>>>>>>
> >>>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>
> >>>
> >>>
> >
> >
> >



--=20
With best wishes
Dmitry


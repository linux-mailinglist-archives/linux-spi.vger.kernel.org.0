Return-Path: <linux-spi+bounces-4807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B429785BC
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3D52887B2
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9F6F2E7;
	Fri, 13 Sep 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGr7V/92"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02A6BFC7
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244887; cv=none; b=W99Nj4HXv/eSBQdV78U43PcwoJOExgAnMtjBAK9jBsPAL5McEkbM5Sm9NY3HrB4x0NTsTp8I6qWIapOwsWf1T7CZBQ7z/T1yzQDi6Tdu5a4AhCWDEoym2PpdaEqk0S+LOlW3d3uM5zJdOalfWyaNHKKaFvTHPVfB3olPQOQi/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244887; c=relaxed/simple;
	bh=l6fQQfIJrCnieXnJtgF3yWwkk1JOKa/ssQuU9USSh54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbx/xI9CWSyeNxD/brVukhK2bprSjP7ACSQ2RTte6KXe6gt63bwHH/RSur81cQ3q7i0dwYkPAh0A8sGYykIEtzyohbgDNfZlr3bFkGp0tf6VuVpyi7bHSKx00jG/gBTK2yjJxSg7/DmBJvZ54D3+ry6PPpynTEqCeDUVe5OiaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGr7V/92; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99e8c32c0so222221985a.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726244884; x=1726849684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MySfAV1H+y1ji7wrdPmDhE9q7agfjXhZS+w1J3QnDfE=;
        b=AGr7V/92Ccvh2ei+H3/gjhiw71ZoSCNCUhMriUQ4BlAbHantF65uBfx7vg+eEefmXE
         Cs+qy4mjox/EiuRlPGTc6loAydW4F1JELiQ3+Ia2E4XTf5jvNP14CmOCyMcg8Zd7X+n1
         kUdYnMPHcw2XrkeK7lkMvA0aHpAemdplbGITY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244884; x=1726849684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MySfAV1H+y1ji7wrdPmDhE9q7agfjXhZS+w1J3QnDfE=;
        b=sB5FoAUd7imsHyjLw2hTQ6qH7h8BbL0LZisGcM8Vz1HWgLchl5Artp+BtOQIBO5tVm
         BrzsNgLC17je8Vpf6RdPcL+Em1y3NIWLCAtCE0ETPBJR0TEN6LXMM84cBQMzKdjAXAdF
         YwzT0SJcgdwjCPakJk9DU7oYTX0ZtwU3guOm9+hOC2JRBdranah+yEzuInlxMy01KDA/
         d6muJKaqsnitx7cyeZh66plkfhTBUqRxo9ZrdmvYxGyNpWcsv2+yrtALmOsdpqhD05PQ
         p9w7zHtQFsAMMrzFb7JuTm77JOwCu4HriGM9+eJuWJANiFbnSMk8ljfp/1kHOO/IG1pZ
         UTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhBDCaqY36MUy8nvulW+zdqJ24pG5ijtA7NVihF5lWIeVTUEcdWXPGuyTr/aqicTGdJgc+Zf+2lcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDmr6cqL0ha0hi2JsFYjWgkQD9BwawmkBxZDWZ5EJQYjHJN1h
	3fTz7ve2eXhpi8c8cic3Y/t3n72DGUDtrQsRKjHPENb3zC9ExOdLjC7QaSPH+/vH5eOqNCP0vuQ
	=
X-Google-Smtp-Source: AGHT+IEVojy+zn4AXaKcQiyuHDS8653Ds8XddViPAnJK9EcUT3qH+P7C8fUapdZKZu7+3cj2Op6apg==
X-Received: by 2002:a05:620a:4508:b0:7a9:b114:471d with SMTP id af79cd13be357-7a9e5f18a6fmr1280490285a.33.1726244884239;
        Fri, 13 Sep 2024 09:28:04 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ad15sm682399285a.30.2024.09.13.09.28.03
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:28:03 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45821ebb4e6so18205391cf.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 09:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhRZIa+XanE1NXkQpPfNZ3ignumWDmpmBkGSGtgTHMBGy2RolKai55GHN6cMv4iWQcL5tXRdZfDzU=@vger.kernel.org
X-Received: by 2002:a05:6214:3a86:b0:6c5:297c:da5f with SMTP id
 6a1803df08f44-6c573570b58mr118095856d6.33.1726244882965; Fri, 13 Sep 2024
 09:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com> <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
 <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com> <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
 <10e77c5a-a188-698b-0c82-86c4bcdf114d@huawei.com>
In-Reply-To: <10e77c5a-a188-698b-0c82-86c4bcdf114d@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2024 09:27:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
Message-ID: <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, vkoul@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 11:44=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
> On 2024/9/12 21:38, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Sep 11, 2024 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> >>
> >>>> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_dev=
ice *pdev)
> >>>>         if (ret)
> >>>>                 return ret;
> >>>>
> >>>> +       ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_c=
han, mas);
> >>>> +       if (ret) {
> >>>> +               dev_err(dev, "Unable to add action.\n");
> >>>> +               return ret;
> >>>> +       }
> >>>
> >>> Use dev_err_probe() to simplify.
> >>>
> >>> ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas)=
;
> >>> if (ret)
> >>>   return dev_err_probe(dev, ret, "Unable to add action.\n");
> >>
> >> It seems that if it only return -ENOMEM or 0, using dev_err_probe() ha=
s
> >> not not much value for many community maintainers.
> >
> > While I won't insist, it still has some value to use dev_err_probe()
> > as I talked about in commit 7065f92255bb ("driver core: Clarify that
> > dev_err_probe() is OK even w/out -EPROBE_DEFER")
> The main difference is that when use dev_err_probe()=EF=BC=8Cthere will p=
rint
> anything on -ENOMEM now.

Oh, I see. You're saying that we should just get rid of the print
altogether because the only error case is -ENOMEM and the kernel
already splats there? Yeah, that sounds right to me. That doesn't
match what you did in v5, though...

-Doug


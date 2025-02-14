Return-Path: <linux-spi+bounces-6833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B132A36174
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843897A6AEC
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A722673BD;
	Fri, 14 Feb 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHEEeXJI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A602673BA
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546335; cv=none; b=rexR3XsiY/yfN2vPNXod1frRFE6MinilGCNlokioaS7URcmza8XBs2cmkzhQJTxNFjSxIKQXgJvffChPQppNK/zgMeQ8oVM4vOhclE595Oct9qkyoLd9c2Vva0wXSH8H3WNM6D+0t+8SgRHhPP5l9ZlAZEAPpCg7UOjOpPdku9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546335; c=relaxed/simple;
	bh=X6fmGX2I2dkDJfx+wdUhyhODSoxO3XWWRG2Bykz8K8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IELWqxC4QpateKeKTeYRtBvHovVlAxJLnx49DnGUbLHI9TxGY5IuttxpMEmrgfVaUBIYL11TWTjC8Nsq8KTnDS8SD7QVzrhFmxkJxyv24GZXJFcwBKr0dyxi9fusmGLWvdnoTnFf2ZNbyZfplUd/2dBo3UpS4vCSGPmgb0kC+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHEEeXJI; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e46ac799015so1622988276.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546333; x=1740151133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vud2l+W++O1Da7DS2WaNrJ9AJreXoCTXE/UW9zsHPAo=;
        b=MHEEeXJIISHWfi8fFGNS5M/0sHPie7eQ5FOJ9F1uCHkuU8IK8hRpE4bcOeeU12fVct
         L0iDQa7sqUqzXCftkjagqPZSlhEiin4phboJWvDzYP9d80mnIIQa0ArvHid9QAPZQqB7
         /DkfK5W1c+nLJvtNUZGebvj5oefK92C/XxUuYn3QWO8w7wH6GcoQWkNBvlAVlsDu9Ea5
         W0UKpUajgUjWySRIp9j/rK726/7MYcqGt/KhgelqRF7jbUZQtQxiT/Xdtb06TdDGXaoI
         azCrmZCGp0tS1jvfaYRo32YpJMhHx/0MXYOLQ+1JBunZRarjfae4inou7SLzB2wmgyzU
         EU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546333; x=1740151133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vud2l+W++O1Da7DS2WaNrJ9AJreXoCTXE/UW9zsHPAo=;
        b=EG2JdJh7T/E5wAZlD1Gd/7Azvh1elYUAWrQCnuI7WvDLIFu71u0FAD2lOKJoRWm14b
         2tk9UIy3/g8CVws8shR7KCNf2uzyOYWGnybQ151J2drr83ZxwV5C490RAd1QTv/CRrpU
         0MAJBp4hWiGInlhAtS/AdjZ7s7Rva++J2e/v3jNoliG5iZ0dj8PFdHpGMag4GOIZC0+r
         10gWO+52zxWf0FOBRJSco0Llq2ECzxNEE1LHKINOTgUvXsOIhgkmJ9/3WlZi74DxY4Iz
         L7zusBfpWRNq7ERm/z7eEVcZkREdXf4xUpF3RV26j+8xClQq38UCWNdz8ljQ3W0sKxHe
         ip+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzByPoO2RTCWdzSYIrkF8kILfvv2tRDiHWNzKVoAYKw09C5thorssbT4wESH4ePxGUD2+gpl9ZdxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZi0pzjhNgCA2E2a4NpBd9Zbkg/z1iOEyiOzjQE9SF1jThOZ1
	GYKEfjXlUEdyv3CDPCopzTLlnQTdTgrsNOPvxJtWUF7cU7GJh1xpKTTn3ctdzO2UTwpWU3h0iZ2
	ecCs2tM18io7wgFAJtxFIvxA0PKs3TwkxRRT2rK1FfcNOFUX9
X-Gm-Gg: ASbGncuoVGqeR90KDvZL4FRW4HFyB+eto/jkxvxq803ao543Smq/g5zwLkKMNO7CfBv
	uMHAt3cAYvGs7RDQEVUwRBZeB4PQCYqB/q+53YdqkU6po1asb/qzRVkN/1K44lKIJkLiGxg7aNs
	nPy5rMGEQLv7K4kvASCg0BoucNe31KVHE=
X-Google-Smtp-Source: AGHT+IHBLi+DSdWwdkBiZJtFZDCRKWBo+hYt3CPdJ1MsUWNFmP3OHtc7puT3fPX9/BKcGYQszQlVBW84g9IFUoqX2jg=
X-Received: by 2002:a05:6902:10c8:b0:e58:4a5:2ca8 with SMTP id
 3f1490d57ef6-e5d9f17a12dmr10834168276.37.1739546332754; Fri, 14 Feb 2025
 07:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
 <20250213204044.660-3-wachiturroxd150@gmail.com> <CAPLW+4nJVf0raJ-O3u6uUteBi--N5xGwvzXp7cHqbkdMJ8gCSQ@mail.gmail.com>
 <cf0a5ab5-265f-4429-8c11-8b669f00bc70@linaro.org>
In-Reply-To: <cf0a5ab5-265f-4429-8c11-8b669f00bc70@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Feb 2025 09:18:42 -0600
X-Gm-Features: AWEUYZltiapjR3VtfT1WDOygMRkvnzikuCurH43pDPL6b-n2GaubYKFDPd37TJA
Message-ID: <CAPLW+4nYMShK=mgXcct0QFQa_bTLcdWdcCOKSToxgx8tWqTreg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:39=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> Hi, Sam,
>
> On 2/14/25 12:08 AM, Sam Protsenko wrote:
> > On Thu, Feb 13, 2025 at 2:41=E2=80=AFPM Denzeel Oliva <wachiturroxd150@=
gmail.com> wrote:
> >>
> >> Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
> >> Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
> >> configuration port.
> >>
> >> The difference from other new port configuration data is that fifo_dep=
th
> >> is only specified in fifo-depth in DT.
> >>
> >
> > In the code below I can see this bit:
> >
> >     /* If not specified in DT, defaults to 64 */
> >     .fifo_depth     =3D 64,
> >
> > Is that intentional or is it some leftover that was meant to be
> > removed before the submission? From s3c64xx_spi_probe() it looks like
> > the "fifo-depth" DT property is ignored if .fifo_depth is set in the
> > port_config:
>
> fifo-depth in port config is intended for IPs where all their instances
> use the same FIFO depth. fifo-depth from DT is ignored because the
> compatible knows better than what developers may in DT in this case, it
> is intentional.
>
> >
> >     if (sdd->port_conf->fifo_depth)
> >         sdd->fifo_depth =3D sdd->port_conf->fifo_depth;
> >     else if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
> > &sdd->fifo_depth))
> >         sdd->fifo_depth =3D FIFO_DEPTH(sdd);
> >
> > Btw, wouldn't it be reasonable to flip this probe() code the other way
>
> No, please. IPs that have instances with different FIFO depths shall
> rely only on DT to specify their FIFO depths.
>

Fair enough. Does it mean the port_config.fifo_depth should be made
obsolete? Or it makes sense for older SoCs where FIFO depth is fixed,
or something like that?

> Cheers,
> ta


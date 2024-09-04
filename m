Return-Path: <linux-spi+bounces-4634-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D296C5B5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C731F26D92
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FDF1E1A05;
	Wed,  4 Sep 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOUtLyhd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8271E133C;
	Wed,  4 Sep 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472059; cv=none; b=aWJvKc2pZ4r3yOT6fGbTNkStiZyXijf37o0UVjmduciODBk9+rfB563xhxEzJZ3BbHpwYrn5Mp1Q+KTfZC3PwuMTiifv3GaNHV5WBx8+hpMKnz9ZDqnZy3tNsQyr92ykIaaL85ZK3pK3BLsGsI6ssAyjbYdZPXicJModV2fdIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472059; c=relaxed/simple;
	bh=AoYwts8Ab5OPLrcSFhuWwguG0GQ8hqSCwvHEZa1WsgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUcFVWzvEVcdhmPITtGF6Oli3NJRkO9OaJbmtloBR5aLeWuPaY+SVzETuddDE3FUkVcd6ayIniiW/qXSORlZMktQe1998HklYQCJml0AISM3UysH39czJHBfHEmSWtDVfexy82HRwXYsI7ChR9pzC0hNMRlrNxb+iZcFfhUQ0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOUtLyhd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d885019558so3687589a91.2;
        Wed, 04 Sep 2024 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472057; x=1726076857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoYwts8Ab5OPLrcSFhuWwguG0GQ8hqSCwvHEZa1WsgE=;
        b=lOUtLyhdL0ZBp0INLh0DH3c9GW5/ilPHrHO/aQslhzWfu2DaxbcxhubaS5SATtnZuj
         jhIAhUvreZOndWYZMGtEj07DJ7He8Koe1OKjTUiGgtMRIjAlXOKpkl/UlqXJ7m5m+pM+
         h73/xILP0ydcEBhOO5FgDJP7c8snUNuaYvSg9DtJ0+4bxVSRVxTxFFCmXyrGp0xuxkGE
         ccBrrCA8YiHKpKkckDWQATHz/ylVnPVcdnt9ySgXaFAV7LfuQH4TQ2suq4OpxWeoYKr2
         jIT56EEKa6juSIamrLlAc61qDGbCrVdl3KWs0zMrjozeBmlE5L3GXiZZF2Xwl9rUfxIQ
         PFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472057; x=1726076857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoYwts8Ab5OPLrcSFhuWwguG0GQ8hqSCwvHEZa1WsgE=;
        b=AruixSdID5paam6a9+1EvxiizFVphSjPThb1pFbXUed4tTOJtVoJesPhuIPfCFvxu0
         YNtMxUp9mA9FDelN7ZLsQdhEHTpyTNevbXcBT604Jyvx1bGEeHC6O6ZYjc0DGskTAYRR
         s/MWaPSL6OkDZKOGwtWMsdPStRTvSOHUatrw7F4uC8Tn3Mt8+arHGk+0QJ+Zuk1Fn+SG
         bC4ux/RsMBdeYniq8Au88ee+xVI18bJIXh3boqR7PcfWbbbPo9qKPdP3EIQ0L21fqSCZ
         x6sm98A7rP77LPouzpUU/CW+8SjnB1imqu/U9yBOqrNM+y1A5vr8kLfdQknqAp2NLG5U
         KQcg==
X-Forwarded-Encrypted: i=1; AJvYcCUgVvh+7GUyyMsoCtxo5yxV6CXIk9ngkNaLwXPkTiaCZWMH30p4+J2rNdCQU9uVkMP21nqn8suctdOj@vger.kernel.org, AJvYcCVHoXCAsu1F/51NmyIBn4K9XmCX5oIu4DO6YU3dqgjY8WQChSliAAN57YhfX6tyrgueOsJq0gQkrOX2@vger.kernel.org, AJvYcCVgrWVnSE2McckUb6FTtI6N7drfruPMDJaOwW38JpSrGdKFD7QgHx9OAqDath8Dn4FOpGQVuXQmM5sSk7Xe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q1++djq15gTIxcaf2WrNkdmHBGMNieiPHCU+YehIQfyy+718
	+XXpnxXtAg48CnpLKMdKvfYjMh7OLuO40trkacTp8GFxZ4LhMWEVy+AnnMXsAbCwTaFsQyrx/rl
	/8wbr/EeEdEJlJSIjrmuT3p76j6A=
X-Google-Smtp-Source: AGHT+IHWiWJLIZjCGcB4z02cOv5ebjyaOvm0yg+2DiKxPuZ/QTuXOOZtwTxvS9SK6t14oV3Hyuqkry8OzNoIuM0woIU=
X-Received: by 2002:a17:90a:134b:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2d89348f9b7mr14904268a91.18.1725472056687; Wed, 04 Sep 2024
 10:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904111727.1834935-1-haibo.chen@nxp.com> <20240904111727.1834935-3-haibo.chen@nxp.com>
 <4664d1fe-eeb0-45fb-8f4a-8299febab3eb@kernel.org>
In-Reply-To: <4664d1fe-eeb0-45fb-8f4a-8299febab3eb@kernel.org>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Sep 2024 12:47:24 -0500
Message-ID: <CAHCN7x+q_pV24Gy-pGb53r2G+J-=mWy7STM9cW125y10JDMYrQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] spi: nxp-fspi: remove the imx8mp compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: haibo.chen@nxp.com, han.xu@nxp.com, yogeshgaur.83@gmail.com, 
	broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:32=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 04/09/2024 13:17, haibo.chen@nxp.com wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > According to imx8mp RM, the fspi is compatible with the fspi on
> > imx8mm. So remove this redundant imx8mp compatible string here.

We'd need to have the device tree compatible fall back to
nxp,imx8mm-fspi, but it doesn't, so the driver would never associate
itself with nxp,imx8mp-fspi.

adam
> >
> > Fixes: 0467a97367d4 ("spi: fspi: enable fspi driver for on imx8mp")
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
>
>
> This breaks users.
>
> NAK
>
> Best regards,
> Krzysztof
>
>


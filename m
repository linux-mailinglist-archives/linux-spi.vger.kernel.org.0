Return-Path: <linux-spi+bounces-8081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9BAB36D2
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50051897402
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5022267B92;
	Mon, 12 May 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlPbOJwn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9C1C6FF2;
	Mon, 12 May 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052222; cv=none; b=BtqwCjKAlY/V1SbcMvA12Xf/qo2yOl4bPPXqNqIXeaeRvDkmQ521qD3xjpAgQAldWS4zyYQXtDJeU1NvNEfOqC32n4MqXodgL1fFR16EHtjFT5aXkKCfFnum1oVTBI09cG4sbps/3QDg2g/HSXKpUMPyeHFzVN593H7WRS/UBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052222; c=relaxed/simple;
	bh=mcT9W2XpGug/PF9XnYH8hrSTEA26BaaYyG5vLPJwSyk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AogndMfxWzSYlhpXnuWA+PtvtQio16UuEP1Z4HTkh/sZ9XFezH0ikbxKXXPp1n8xJuwjrIV/IgRI9P24GJtX/BGgm+A1S3i6neI+ZBgfzcpPT9y1LY0uMU8gwSGV9tFpgozlD6l/2sYa7gKcLR3qxCOYV/U4r/5c7A2HzhJQHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlPbOJwn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4112573b3a.2;
        Mon, 12 May 2025 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747052220; x=1747657020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UT8FxHYTuZLnDZ/LUAeiM7+DFqtM+z3h97KfeLVmQsw=;
        b=JlPbOJwn9LkMLXLpYthT8yGD3yXr0x4CjGj8z1YjoyMVQycjsMUstrAhVNLuG45os5
         eARQTw4SsxU/CuEyx29K4De9XqHg4vDUS+ipC14cIHntRixz5/jeF0U0eEP6zlTEk2rD
         tsL5I6DuUwfbNoMTU6SZYOGUCY6dgaggKis94TbWfs6VLwf+DRp0l4QwF0uaI6Rbo+FM
         Gn6Q0ZgdHKhSuf3glsIQAVipOSVuXYY+csTeKzVtcGVjNT0AkXvwuaSMIUR4nfeupXjK
         3yS8VxzGrREPnNnsmHU7x5lTxtC4KD1rQ/yHTviB7WWl8hRO+RWmxXykd6/ygBjuP7kV
         +VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052220; x=1747657020;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UT8FxHYTuZLnDZ/LUAeiM7+DFqtM+z3h97KfeLVmQsw=;
        b=YEdQUprYDmR4EtzDEkO1zBD5oN4RG8npZUUskhXuwxLMJBk+Iao+/9irq1jZisTQwk
         ryKrVwStbfx35hFyTe+9JihmVb2SZ/CZxj7vsX0yxXrs5ySyVy616THCDQwvUNP3/fnO
         ysw1VbCFc573CX2OCdrZZZ0nWkkjCnV5orTHcJlFP9dQtwYbZAhsR4MB/zukZN7fdRxl
         jshNeCMZQwCnaDOfsoVFpgdVMrQEfRLjOLI3uwq2brV2iOU6X/x6dHZcMP0S3a5KSGje
         QB20YUd3pKnybDrul3riG7HuWAwndHKY0taqvkdytat/T/6aF6fCRfmsnVWZbWt721PO
         jmaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7pdDk6NHuBzuT8HqtBjwpMpBU0ZAI1gO9UBX3OJfNy2p4uhEgTtXpIh3fguDjeZvqyiLZ7Pq0RirF@vger.kernel.org, AJvYcCWNxGfXiaPVuEBC2nzuCe4sjVR9ijPpFnZNEU4BJ5xCCgPZ8E6an33nWVx1GXKjOCw85/f4thSp@vger.kernel.org, AJvYcCXmWqgvnv1UrMxBLy8D/FwiUU/3WxLNJ42HM55jtiT6ib8aC5bekOAoMPocVacExHcKLLW4laPsDmU52w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0mfdX/CMuu/pre84mluHpIFYn04MyCn106jSrBVjPzCy8Cmh
	il3R5G6jLIDRkPkaEBu/ga+Om7kVvemCrUs2GWETwIputROG7DA9
X-Gm-Gg: ASbGncskSR0tzoOjIHIAGJCA494VcXVKq8HFyauKFVTerfHqe/EsyZVZHHocxATSsYM
	9H+2cV/TwvdVvKAG+N5p4vB91S2ni6QJszNYLuk4UVXAzH17HFTK7szODW/3xFKWx6vrSxFfNfa
	vYSKic82HjgO+YBBL9hS/VK17rGh4si/C++Wqgq+UzNYd76+k+FEs0/2/7PgUVOkHGeorkRQOM4
	GXP4pEFOFBuquJCAEUokVB/VuvP5UU9PxJ7ffmdRXUWnGvgJ7q+ulC2HcBNPqhRxDG/3655MWXj
	aewOC5/2vuMxnIicfKtZd8MOi1g1COpVYvf6COT1s0PjbwFq/Xh+puKnUac6joI/yot7n0AQfa9
	2oWuw8A==
X-Google-Smtp-Source: AGHT+IFlczZni4OBHuq4O/Qf3oTFzY2BdnjnEHkE4dmq/Vo7gt0d2DyGDIXpH0W7lsUp0iC1OeuuxQ==
X-Received: by 2002:a05:6a00:17a7:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-7423bc1d336mr19378195b3a.4.1747052220490;
        Mon, 12 May 2025 05:17:00 -0700 (PDT)
Received: from localhost (58x12x133x161.ap58.ftth.ucom.ne.jp. [58.12.133.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3d3e9sm5865409b3a.125.2025.05.12.05.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:17:00 -0700 (PDT)
Date: Mon, 12 May 2025 21:16:53 +0900
Message-ID: <eke7v7q6vxai.wl-kobarity@gmail.com>
From: kobarity <kobarity@gmail.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Aditya Garg <gargaditya08@live.com>,	Berkel =?ISO-8859-1?Q?J=F6rg?=
 <joerg.berkel@bfh.ch>,	Robin Murphy <robin.murphy@arm.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,	"lukas@wunner.de"
 <lukas@wunner.de>,	David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,	Joerg Roedel
 <joro@8bytes.org>,	Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
In-Reply-To: <089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
	<PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
	<f1b41874-1535-4457-9747-eee3d816091a@arm.com>
	<PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
	<PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<eke7wmanw9xq.wl-kobarity@gmail.com>
	<089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/31.0.50 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Baolu Lu wrote:
> On 5/11/25 21:31, kobarity wrote:
> >=20
> > Hi
> >=20
> > I'm also experiencing this problem on my MacBookPro14,3.
> >=20
> > Aditya Garg wrote:
> >>=20
> >> Hi J=F6rg
> >>=20
> >> Can you test the kernel here to see if this fixes your issue:
> >>=20
> >> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14=
944200356
> >>=20
> >> Alternatively you can try compiling your own kernel with this patch:
> >>=20
> >> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@=
nvidia.com/
> >=20
> > As far as I have tried, this patch did not solve the problem.
> >=20
> > By bisecting, I found that this problem was introduced by commit
> > 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
> > In fact, since this commit, it will panic at startup.  This panic was
> > fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
> > pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
> > 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
> > and touchpad is not working.
>=20
> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
> comparison in context_setup_pass_through_cb")?

Yes, I tried it on yesterday's master branch, including commit
64f792981e35.

- Keyboard/Touchpad NOT working:
  - No patches
  - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_v=
td_ss_wo_jgg@nvidia.com/
- Keyboard/Touchpad working:
  - With my workaround patch


Return-Path: <linux-spi+bounces-8108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB7AB5453
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84E019E42BC
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752628DB4C;
	Tue, 13 May 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwSSzbH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9151FBC8E;
	Tue, 13 May 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138141; cv=none; b=lQYfsQM5oK26546usj4dro90DTkohBaLu9Bcl8MKbhbqNHx30ChtTQXeGf78aENXGPBlX78xBn/wDdY0v4RdlvvZacGFKIbWOb8p6qEyk4K9LDGsRy0f5kWlbI5cna9dMrhLUMH8CApibIenidElPwyG9MLpyk7lregmmSGgNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138141; c=relaxed/simple;
	bh=2XUeh0Z5eCrhfaTA1VOhp1BRJwhiEmiLDGJ1gReitKc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENJvvpV1h0NfWyzDoLc0cFwK4fe9WGRf8KdjE3M4kLw3+mkXP+lP5OLM+R2BX5a5+a3l2SXtuP1inyGTTgdDGC1pujGCKOP9SfxAXJ+a7WZvoV5AOA/z2z9bOBrpzzOTSFWcpsyqrLSTiTQy4bTxLZoKydeWlAS6y82bJe48T7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwSSzbH5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5468635b3a.2;
        Tue, 13 May 2025 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747138140; x=1747742940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+fiwMr4DtCBa0BKgRSBqKM/6GNS1IOnhbc+D2U/YPs=;
        b=hwSSzbH5ao9pHweSRoUw+T2PIUNXurQwmbl9yoZKADfTi5ke1ted+3JONDWAorhuWu
         F+Z12jDswVbI0CMN2oQSnW+FJkbKDLtxtBsAZGbZwOXKnfNCq1gxW0T0YPM0nawLEU/z
         I0FfoCfVIIms3ABGhx3+pX73Tj3JAeynTYbXQWk18CmPxtB6SBUyl3H7xbZVtbIqdbt+
         HYCiTStfmf+iIaVwPovKN4QogFPA+gNdxA2TUlwpsjS7SehQgpqinCzeZokgWrRIDBFe
         uxFr2FfZAs4Sj4zMO/lKdGKwHEhHFneKl0nAViL7LQ896Wu6jPxwhCTjkTGahTOZ3p2t
         L+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138140; x=1747742940;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+fiwMr4DtCBa0BKgRSBqKM/6GNS1IOnhbc+D2U/YPs=;
        b=SCOOUzf25UIYKRWvqZ+boW5yM7aR41YOyyOb2HAvI5CXR9ojiPcxrNhOQSb3CyVZS/
         Tem7w+Qh5alt0tik3jVdVGn1suLwwU9+/Gka5huhXbxqLDqRbHqAR1jfKKOqVoKeVHEK
         zYsMlIUsUVpn+CqajpN6TGaEHHdk3xe71hYJ9ez6k2wp7bYgEFr+HtLV63iho28S47zU
         S/G1+nRQ3lDGR0ktkQdTCZheveRHAoJMsyc3G2Lp8S07tqkcijidBKZX8rHQDpdi+zx7
         aXVNS9FKpt+d5ULBbR7F44scBaJFEdKlWtaqKoL578mZ3dqKCUi3RtF+yS0BjPcj8dNu
         M2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI90MHU0aJ7P+BOjZiIywB8kKuvLX09nANkB5PbiLcvUWU6kJi1XD7OjSjUMbaBAy6Gl7ItVaF@vger.kernel.org, AJvYcCW9UO4W0i8YEb/559mFZz1+DsdFHo+j46mS+L9JIgffQLBLQQ2pYkh1e19UU77LeWehS08SJQli6xy1Ow==@vger.kernel.org, AJvYcCWP1WWqo1YJeNO0MhJYfoaPsd1K0WCGPD2dh9uXJ+yurm1x0+bXztd4gZH0uJy63rEGTkuoLfQQJCDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwFghsANZKwoPPdDKNgLY8gzyg4aweb88kTUOSZUi7Innz+Ua82
	AgWIRlP0DNFnuXtqPabEylcxegBklnDUaIVT+8NdgZF+5me42LYL
X-Gm-Gg: ASbGncu2OK+nKAXAqhncytDjAW7d4dZkzpAvKroL2nJDfGDEdwSEXNC6XTuKE3Lcozc
	MkVpWZKqQ3UqcupD6+3cNyG8QggIX0qswqDZbbp1sMZKZkNMb1CxSHsvujjknQUmjjwuC4YTO3v
	njtyGggdtywbXNNFB2hWKghMHa8YG2Gey8ZTAdZLqTODaoMC1DzJxLyGqLBfSmbwf6CVLE2BM0q
	j1L0EO364cJeu10p4h7ozgmtuCfIfZNW0fhI+kuV1PyFuTVWKR8HbCjk1ITDaDZRZpV7uvltNcJ
	pdTlhHZ9ZHJPpUnetXcS5cPe74yJH0OgFMH71QYSaBhsU4GVOKSQLWmst0EE/tJ7gt+B1ukAHl5
	ApuoWvA==
X-Google-Smtp-Source: AGHT+IHJGLfjYB82MfeuCRiDY5iuey+WzblyJnDvkjQRynwrBn6xgBlO/6J7o/bSCimJvfFnIprkHA==
X-Received: by 2002:a05:6a21:3416:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-215abb0b768mr24877844637.11.1747138139597;
        Tue, 13 May 2025 05:08:59 -0700 (PDT)
Received: from localhost (58x12x133x161.ap58.ftth.ucom.ne.jp. [58.12.133.161])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2349ec816esm7161049a12.22.2025.05.13.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 05:08:59 -0700 (PDT)
Date: Tue, 13 May 2025 21:08:52 +0900
Message-ID: <eke7tt5oww4r.wl-kobarity@gmail.com>
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
In-Reply-To: <5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
	<PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
	<f1b41874-1535-4457-9747-eee3d816091a@arm.com>
	<PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
	<PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<eke7wmanw9xq.wl-kobarity@gmail.com>
	<089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
	<eke7v7q6vxai.wl-kobarity@gmail.com>
	<5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
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
> On 5/12/25 20:16, kobarity wrote:
> > Baolu Lu wrote:
> >> On 5/11/25 21:31, kobarity wrote:
> >>>=20
> >>> Hi
> >>>=20
> >>> I'm also experiencing this problem on my MacBookPro14,3.
> >>>=20
> >>> Aditya Garg wrote:
> >>>>=20
> >>>> Hi J=F6rg
> >>>>=20
> >>>> Can you test the kernel here to see if this fixes your issue:
> >>>>=20
> >>>> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/=
14944200356
> >>>>=20
> >>>> Alternatively you can try compiling your own kernel with this patch:
> >>>>=20
> >>>> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jg=
g@nvidia.com/
> >>>=20
> >>> As far as I have tried, this patch did not solve the problem.
> >>>=20
> >>> By bisecting, I found that this problem was introduced by commit
> >>> 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
> >>> In fact, since this commit, it will panic at startup.  This panic was
> >>> fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
> >>> pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
> >>> 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
> >>> and touchpad is not working.
> >>=20
> >> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
> >> comparison in context_setup_pass_through_cb")?
> >=20
> > Yes, I tried it on yesterday's master branch, including commit
> > 64f792981e35.
> >=20
> > - Keyboard/Touchpad NOT working:
> >    - No patches
> >    - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-io=
mmu_vtd_ss_wo_jgg@nvidia.com/
> > - Keyboard/Touchpad working:
> >    - With my workaround patch
>=20
> Okay, thanks! Can you please try below change? I also attached a diff
> file in the attachment for your convenience.

Thanks!  The keyboard and touchpad now work with this patch.  I tested
it with the same master branch as before (commit 3ce9925823c7).


Return-Path: <linux-spi+bounces-12079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC4CD7E70
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 03:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB2C300C0CF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 02:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DF23D281;
	Tue, 23 Dec 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T0cNgHeJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127C8460
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458165; cv=none; b=XBi0mQWx1SjuU6sZ5vTIEgUnQ13/kgXkwGSDXLWnr2Oz3uesm/iIOMRml6B+lqv/nY1+dwcBiZoORsOd09xKiReifNqPwg2nYrJLBEV7HskOsC3AQmt5Io7tLxOspnStIYLxJoypXxLgZhmJEwOJYdkrkzZGYz7Ej3IkVl5cKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458165; c=relaxed/simple;
	bh=uipScwHb+CLYuATRfo1cLseXbi5OUaYc3FggMDKd2r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sre0py8EmRmxoQ1szUAKHFipiGzDwhUZ2v+aduJa/wrciwD/JtM0rx9tfC0GBNY9a+5jyTWrFdT0Vt7QfVDW9eQUu2Q9MIJTAEdu0zjgAq+IeudwNe+LChkrXx9mR2nCCZckHQ0z/FY4BAidgkgkojKwzPEYu4QcumE153Y0evE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T0cNgHeJ; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a097cc08d5so9658905ad.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 18:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766458163; x=1767062963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uipScwHb+CLYuATRfo1cLseXbi5OUaYc3FggMDKd2r8=;
        b=I4yyvFmdYF6lc5J/h5bSjrbXAdSOMdmQOuWO+XEWQLUfqY4/mAvkau24i9lFCKYeYf
         mqgvs5xajxi/n3LMsdKzjaJ4gHVsim15ei3sXmtJWT2O7k/ru1xfjq1VLV9xBFY4ICv2
         Vo05Z7rYAmUfVUInpTNtOgtgEKvZXRCG6+VZFrsnb8EiQqfOKeh5ZbVFlpelHG52P3Th
         5fki3Bm/NR1rVdfYincDuPW5F5gsz1Hy3HXss0YA+p7161bhvAwY05TsnrZzqSOxSgly
         JlvMazcxIeUoI9CXc0z5pMcLR1Ayksr8Co7dq8mlbDYRLaMTpwvC6ejsUL77XTw4cd7b
         VXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoRKtmYzr1UqlkXmxZDDT5UVbJgixS1n0fuOayynbHZpiEV/gLU3Cm/UczgvaSiMfvmQNuQVeu6/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3eVxTqv2wo0x+g6rBn/fZLarnHeqv8v6iErcpITr/d7b0wW+
	KwByRaP0NBgs0wDjpFuOfjLpvFtUvdXJWgdeyhii+IKnptoH8r617ilyPJs4pmSnbesu4F9xOTV
	oAWmAJ6pimh8GCpGyq0s6hvrPW3ZBb08EWsfCMbmq+nTUJTsKr9lB3hCdJ6RJihkyFs1zylCekt
	GAU9AoR6vmdvZSkdkokWfeJ+uOVq99drvitNLzGSjbRSC/qQKZ0OQ6znsyAkg2ET4KdVP8s7Mvg
	k5OUtFjE8P2Zg==
X-Gm-Gg: AY/fxX7ODDzYoSyeMl0d9Mi8dyibe4srYyoqScolegTkvhuW7HBmdnbL9TAFplHScYc
	dv6+bRFqP202lvrN2Hi6N9t6lRH87Adb7b9jnXTQzazlieEe3KcK3g54LmCuh90Qs/l9M6RoNt9
	hguT/ZDfEerLP6XJ249KGmNdRkTGvqmCClvTGk+3n19d63190JRMFkX4PijpLg4sciiDkNFHlTp
	7Sn1vDtuFWhwNyBnytd60ESEx9EZ64LdmdeAYgyYUfLPqxSGYmGyTdLB67SylO5x+H+9zMNFrkA
	HdrrUVGYBa5nyQSdR1Rg3XYGbu/bPlJMJZEY1zD81ENFVIwjmmk1OZ+Lk1KN3v36gfo59cDyZvf
	AdT+hx+mLcqfagNDd+KtLnNUKZMwTohkZqOZBJp/4Iw2U8jtiEKXc2uw1FEVODiIlyrfiwasXSF
	AoipZAbZ4PbkXd3GE40NtKVdJCgAnKASGY6K2Ft1r35Xc=
X-Google-Smtp-Source: AGHT+IEXeBm5e8WLMDSAPdeuXi7qb3PG+CABrmWn3zISU+6tXyBTicBCC+c0ffyM3lt3MJIkkj/5/IPhdFK3
X-Received: by 2002:a17:90b:2692:b0:340:e0f3:8212 with SMTP id 98e67ed59e1d1-34e921e719bmr8415162a91.8.1766458163483;
        Mon, 22 Dec 2025 18:49:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34e70dc3795sm2074499a91.6.2025.12.22.18.49.23
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 18:49:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a1383d3480so15897135ad.3
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766458162; x=1767062962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uipScwHb+CLYuATRfo1cLseXbi5OUaYc3FggMDKd2r8=;
        b=T0cNgHeJSyUUOWcErXmi4VWNBE9BfAn0WLh6PmQO7vddRpKzLxHqR/tOVQu3VNs9Q+
         uw9xf4jD0PTeORhh2mCe+YeixoosNFkLR0i379m13BygOSy8ehzsjbDokuxIadTclHb8
         nEno0yUR7/dULVMuO+nce0H/snPwWaMJmMgzY=
X-Forwarded-Encrypted: i=1; AJvYcCVWMCpO+o/KsP5ImLKI99+Crq0TZOMU0dF7VQrGlIS2sbrvI3p5kUqXORu/lBpdK7CdSDcFVrrUlcg=@vger.kernel.org
X-Received: by 2002:a05:693c:8399:20b0:2ae:5715:88ba with SMTP id 5a478bee46e88-2b05ec6fedbmr6176044eec.8.1766458161638;
        Mon, 22 Dec 2025 18:49:21 -0800 (PST)
X-Received: by 2002:a05:693c:8399:20b0:2ae:5715:88ba with SMTP id
 5a478bee46e88-2b05ec6fedbmr6176036eec.8.1766458161121; Mon, 22 Dec 2025
 18:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217211026.173946-1-jonas.gorski@gmail.com> <CAHi4H7GOXjtVR-y9=dEiwizX14VcEp808fpKdB+x0J3HmYM8Ag@mail.gmail.com>
In-Reply-To: <CAHi4H7GOXjtVR-y9=dEiwizX14VcEp808fpKdB+x0J3HmYM8Ag@mail.gmail.com>
From: David Regan <dregan@broadcom.com>
Date: Mon, 22 Dec 2025 18:49:10 -0800
X-Gm-Features: AQt7F2r8qIhT4W0LWvw7-cg_eeyPidC2i08LRkEO7tqMaVG6cvFqneDM7GpcUmE
Message-ID: <CAA_RMS4-U4kz7JVvB-N4B9RCK3Rh=9E-o0LctOsr-O7OEv19Zw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Regan <dregan@broadcom.com>, dregan@mail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi Jonas,

On Mon, Dec 22, 2025 at 6:30=E2=80=AFPM William Zhang
<william.zhang@broadcom.com> wrote:
>
> Hi Jonas,
>
> On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.=
com> wrote:
> >
> > Add support for 1-2-2 read ops by separately calculating the switch fro=
m
> > single-bit to multi-bit, and then switching within the prepend data.
> >
> > This allows us to support single-bit write followed by multi-bit write
> > followed by multi-bit read, and we do not need to reject 1-2-2 read
> > operations anymore.
> >
> > Tested on BCM963268BU_P300 with custom fixup to allow 1-2-2 on the
> > non-SDFP capable s25fl129p1 attached (which it actually supports):
> >
...
> > 2.43.0
> >
>
> Acked-by: William Zhang <william.zhang@broadcom.com>

Tested-by: David Regan <dregan@broadcom.com>


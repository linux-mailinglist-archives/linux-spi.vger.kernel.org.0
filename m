Return-Path: <linux-spi+bounces-3731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20692638F
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C91C210F6
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626517BB13;
	Wed,  3 Jul 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9ZzeR8R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215081EB27;
	Wed,  3 Jul 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017471; cv=none; b=sko9DJNOpp8q4prMgr0mrr2t1Bfwl6D+zIrfv2lWpuYZmFbtYCIhSvvGU44tvt5VXuPu8x7HD2NrGA0ejBhNQunNeZYsg8X83pTJaiIvDgVudsk9QNQbUR/Bsdm5BEvjU4sIHtQdxszyU5T++gOFIfaSU2k0Dgtx09UjF8RPRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017471; c=relaxed/simple;
	bh=SwDgSV4xuIwT4NzMnJP3OHGqqOb1AP31ToR21/wZI0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+Oj96OjapTYiDEVs8KVTRTfYmf1egVHwI1BbXj40vAvrpAxr1119BOluRY3YAdr/G8LsOg8zkqfGmYcGZMPHb/5XdONFcCwqY82uudgSQbD7MUN8zDIdqhIEAAJbfxCTnXAvVLFcCI3Zqc0kDroKSQy8F6Z7SsTMg5jjWMJzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9ZzeR8R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f341so2050184a12.0;
        Wed, 03 Jul 2024 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720017468; x=1720622268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwDgSV4xuIwT4NzMnJP3OHGqqOb1AP31ToR21/wZI0s=;
        b=Z9ZzeR8RoyO3TRghqKsDUJqTVv9359AcB3IpEJyfYAJtwavJc1rI33kDzVw/cLCkxK
         86z0FUtunmoxSuZUlbavf/vRydTVP/zRCMCrPnPHm+nHsE8dmWRa4q6egfB22rjkkgdd
         h7qrO6YcZNBKfDuhVmSy5IUxStJNagVsS9HQgJxU1JGafRP0J041KcIwPX3zzknRVjvZ
         E9LLiMn0Ge34qUV//dXecVDz8qfcg+YZyDYuWUEGANpAmEFluXnRbqDbt6WYsWW8C8xh
         lKsgrRZJcYggSTUKrN+fjk6wNZe+bah03aZBuWemroKR/uKp0wYb2zjc8j20/ZJRwunU
         oQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017468; x=1720622268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwDgSV4xuIwT4NzMnJP3OHGqqOb1AP31ToR21/wZI0s=;
        b=h5ewcg6DWrUFamE6vdmlB/HJ4NcV0KB7hJwa8T1sC9FrCHL21xCnSbD1qp5TE2Ibur
         /f/Zk27M/YNMQffEt3cIlyptHcTBJPWMWfmVbxzKDJCW17c5JvWxaWY1qHfhdvXgFRtj
         ThvbpXkC25E9Y0A8iIDnHiMsY0Zq8nNGxHg8EJLmnk9gMbUpKywSeSFWuCCbZsVh/vtx
         nHLDq7qqXTqgW6orPKAQzyTVs0C6RboKoiciVFxc0M+TAsCRPq3bkvdEmydaiAJPaN5W
         WgiNHp1lz/EPL9BvnIj4abVQb+u8Eq9UdVJS7vSfdcJFh5vr+rUeO2XnILKOUXvuQXmm
         UPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ep0aya4NuUBERNocCxPFgqVguAMTi7GcaHlPpOZ+Qbuj9tHmx4dcbYkeVseRKe/A1sPRMsivov9BFogRZnbeCXRx/Y6Wjzx5jMmieSA7ke3v3A6YeKelk9slVoep4CUvQP8G4cuix+F6uodtLNUVsUJPCsFyovI0+gN23fmpm9Yoxw==
X-Gm-Message-State: AOJu0YyEpP2qVYPtl7VqjBvQnn6YI2rNZ59dGmbQkPM74Wxy/QCzqvOx
	M9fOg+qx5d+ATJcXv/C2IID3v8YzJxVy2AKdN5f/uCm48AHRn0DbYSCXhUMeJdPakhOXQLratEy
	+iQ++ektffpkmGbo2g13yLuw6aq/BOMYh
X-Google-Smtp-Source: AGHT+IGXO+EsJGw5x4C61DDXzb7+HPJhRuNtxjdmHXW2WRjQgxUdXvXiKtXC11EHY8MZzkWANfP92lKR88EI3QzTMmM=
X-Received: by 2002:a05:6402:2354:b0:58d:10a0:36f1 with SMTP id
 4fb4d7f45d1cf-58d10a03a73mr969665a12.23.1720017468217; Wed, 03 Jul 2024
 07:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com> <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
 <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs>
 <20240703-garbage-explicit-bd95f8deb716@wendy> <CAGLn_=tieSCGWix-0mGC7n8MnD46WPxuWh9xhtB6r+YZry463g@mail.gmail.com>
 <20240703-postage-absence-15fdac24421c@spud>
In-Reply-To: <20240703-postage-absence-15fdac24421c@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Wed, 3 Jul 2024 20:07:35 +0530
Message-ID: <CAGLn_=vpXfCPaWXpeOEfUY3CJEWbp7TMOQb0A5XbGLAPZJ53jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:57=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Jul 03, 2024 at 06:42:46PM +0530, Kanak Shilledar wrote:
> > Hi,
> > So, I will drop this patch.
> > In the next version (i.e. v2) of this patchset, do I need to include
> > the dt-binding patch as it is already in for-next.
>
> No, you do not need to include the binding.

Alright thanks for the clarification!

> > I am waiting for comments on the devicetree files before sending the
> > v2 (if required).
>
> I'll try to look at that today, not super sure if I wanna pick up more
> patches for that platform with "fixed-clock"s, but I'll comment that on
> the dts patch itself.
>
> Cheers,
> Conor.

Cheers,
Kanak Shilledar


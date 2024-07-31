Return-Path: <linux-spi+bounces-4107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FD942859
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 09:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DD3283DBE
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293C1A4B2A;
	Wed, 31 Jul 2024 07:45:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344018C920;
	Wed, 31 Jul 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411937; cv=none; b=SIFPvSb2yv8tgFExITTKxwynBMHpLs2GCj+wakoprebom/KEYIVbNxHYCmorxjguIVrBxJGmKMqATAH57QyQt1tKcVYsFnBn4N14I22kqes7p7UXKPIKZwNMwhOoDBh5dusjlZrzHCJdl5SbU+FNsbe1MzjYi+Hh1XSpqPSEUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411937; c=relaxed/simple;
	bh=7tRnYZFqC1LmQM7QWsw9aJXGNGWSfRmITKOGM/tZmoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6kCef7vjB2K5/B570Q5rmdwe6OSXF6t9y/7K1yeOOLs2PQuIrB+MZ1mN5SMHxTRNUbnLVOTHAWZ0Q7X6pNcIF0+KBfZGLQIGYKCISCYJymRkncgVPqci5rIYFXrbFajGOOAv8YAvhKFeWPa3teYy83RusHLWaJEvhP38czbnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6678a45eaa3so42399747b3.2;
        Wed, 31 Jul 2024 00:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411934; x=1723016734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPirfEU1MnnZLeZxD5mak8FzlxE40SuegKf6iaiXOvc=;
        b=XlJAt4lCQzL4valSd0Sd7eyZfT7UF1O1yjkgwVtTK3Efks4hs99v5T1qkuNLx0ElS9
         yGuA7EXP/OA10sOUn0y0WvfoYHcW47APps6CNI173BoNc5VdQuX4GTr1YICnI4r+smik
         CEqNWhK88ZDm+gdimd5m9zG3A8fPIYKmyqadw2sfHi+7bWz8NYMqzfAFwySECSNH0xk1
         N53ExgljdFbDXUVcGtXyhTDz9YXwdNhBlK9jMUdbMJ+UQ4tbdpJEUofT2FbhUI65dusu
         ABnlcEtxPPo6OKt3FpCqi48y/C7nxZYuG2BI+an7iC8eSzbWbymmoy7Xtund15bicN7U
         p2wg==
X-Forwarded-Encrypted: i=1; AJvYcCVvvrOkTMFD9eZ0sMZIyBms77K0pd8OO6Y7Yuu+mDFOoh0bvOsDMu/Qe2VVqyJ6CfNBMAVfrlT3aZzJNCliLdmBxTe2v/K025vc8nH7FUCtvJJkMrn2BlVhxptbFLQQFN7NxkXyLBlaLyube68=
X-Gm-Message-State: AOJu0YwU/RbPp/jKw0SXNoYU9hpxoNiK7kyBMiuONAWx/ai3KvEpyUjm
	WYZBiaqV7fOXxBVhgf16yT/UZ0zlH6JI97CDvn9TvNZdhCeC3uT3uv81Up1j
X-Google-Smtp-Source: AGHT+IH6BsGyKuZxnzhkxR1Mgl0sKLYFge2u9POcwBOVtS2C8QLUApvRhnb7Lbln58F41JqiDxaZUg==
X-Received: by 2002:a0d:ef47:0:b0:615:2a14:4ea6 with SMTP id 00721157ae682-67a053e0edamr160163977b3.8.1722411934507;
        Wed, 31 Jul 2024 00:45:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e987sm28590217b3.39.2024.07.31.00.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:45:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66108213e88so40025357b3.1;
        Wed, 31 Jul 2024 00:45:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXq67Wg0d9a6ocAOoeW/LZc8h9OLkl4g28tdwBFEtXdLoc14Msu9FXj+bPfS/e+Iw1eT1sTntnkOfsW00YgtUzp1Ufb/GB7az8+xOjmZWriUDkLCqTl+nX4Ta1xGg7T3Zc6KyaEE62M1VPHKzc=
X-Received: by 2002:a0d:f4c7:0:b0:64a:4728:eed with SMTP id
 00721157ae682-67a0acd3c79mr124278867b3.46.1722411934144; Wed, 31 Jul 2024
 00:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jul 2024 09:45:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOZQqHWBXUVJzGfaaLgAnuBxbzp361obS6kRZi7kF3iQ@mail.gmail.com>
Message-ID: <CAMuHMdXOZQqHWBXUVJzGfaaLgAnuBxbzp361obS6kRZi7kF3iQ@mail.gmail.com>
Subject: Re: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:30=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> Add missing MODULE_DEVICE_TABLE definition for automatic loading of the
> driver when it is built as a module.
>
> Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I guess we need a similar fix for drivers/mtd/hyperbus/rpc-if.c?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


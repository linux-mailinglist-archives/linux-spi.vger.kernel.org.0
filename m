Return-Path: <linux-spi+bounces-1754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5F876F56
	for <lists+linux-spi@lfdr.de>; Sat,  9 Mar 2024 06:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4F71C20A09
	for <lists+linux-spi@lfdr.de>; Sat,  9 Mar 2024 05:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52B2D627;
	Sat,  9 Mar 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID0GZQkb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3572D051
	for <linux-spi@vger.kernel.org>; Sat,  9 Mar 2024 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709962954; cv=none; b=DF2159jdjdk2wa0MTyibHclcZlM78PWIRIyJbLgqHfT45pi8qheIkRBoxdvE3Mz9MMxuRXXhRYS8ofKVX+BmKejIMXHHEXLf1OMKMTE2EUQKzvKAlXZDloImteIyLQcy5eWqIZvtqh4rtZnXqx7vA2u6ozcRYEDGXSu1Eaq/rrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709962954; c=relaxed/simple;
	bh=rKuOcZKT1e9tjGefP1VbamIa2R1JXOEQY9Tv9Y4ggjY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=stirVT0ZiuqrDqRSvxNvI21CZtB5dBhvVRP7epAKuGAD8GMbWNK506SdRaCmDmJu6WJ4VfT4cbDapa5ZlV786a51YBJvPlHpAtQjY4PYAdVW09yUx4ybN5e93xMa9hcVTIwlkhmaZSoOPfmdKIcnBi+D3WdavimiKGhCuFSidEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID0GZQkb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29bb557cb05so866631a91.1
        for <linux-spi@vger.kernel.org>; Fri, 08 Mar 2024 21:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709962952; x=1710567752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rKuOcZKT1e9tjGefP1VbamIa2R1JXOEQY9Tv9Y4ggjY=;
        b=ID0GZQkbfkafC8Rm7HizNqFiN3eM3axSsNqIUQ5Lndy+nXGi6f4mVGZrB1YjkkUP7U
         jutB3ekVl+kMKCV1Wv1gBguUZO6xOjPvXqJHC039qbZ3tNzwQk7a312zrN5GaJ5RQy1i
         Oa5Ge7qvAv7wBGoAxNXIJobQ5dN/pQC6XtRpUyG8yN3oSrQaRAu5OdtIaSqLSVo/i6rJ
         wNdPrEHmFGj+1mo5MVcf18KLcn67igHdJt82YkH1d/dglpX4zoRkaXt1+bODFIacjTsy
         p/9ug+MglgPQ7kNx5tdM6Xvpam/cjz3ND8VoN2z56o+vfMfY47C3z0xzMa8jnkM6tRPi
         H3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709962952; x=1710567752;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKuOcZKT1e9tjGefP1VbamIa2R1JXOEQY9Tv9Y4ggjY=;
        b=JmcYMHmQvSFNo8tXbi4OJoCmmtWPOtUr6pQI1GYnL+h4pq+xG27D/0qUl05zf3ljjV
         gdL48UwZPr43fD36BLnje8uPt1a3pwPfA6Pqq3iRjH4btVinLpGoKrrJenF2SRdtfuwJ
         hfQL1FtdOwG8nuHatkce7U6HwHiLb2UT8Rgqf07y0IvkKq2j3Xtu+kxs/hoCgduNYW8l
         ge6Mf9hoTYv2JQWp3QLGjahEVPUu7TnDphOIbZhKUoadyNoy5hCXI+38LMRqBH8go43V
         ts+8zYK2hHgXqVvqW5ZZj9bWMBaQ3GjTc0d1P0q/6TZkZiPjHV72JA0G6T0FSNX7Y+5G
         6C5g==
X-Gm-Message-State: AOJu0YxqqPhyhJKI+tcR7CPT9hWOtPBjT323Tl5DUUW65nOYGeBahW3b
	Ce2P7aqTrQ1eBxOzGtb2F9b8HkndTVdUo5eWT8Trgi9Ws8b8EjNlvqSCS+j4CrAuPGm0qiK+5S5
	Csk8ayjmH3lbze2uqAW6QfL1gDtzZCr7rhZQ=
X-Google-Smtp-Source: AGHT+IHv0jX+cuLH187n8hS3Z8LsnESh/ED2RtG+JJ1P+zYngJSOBK5wrFdOzqspf+lVTalHuIHuZNT/fEjQ0CB06lk=
X-Received: by 2002:a17:90a:6047:b0:29b:789:802a with SMTP id
 h7-20020a17090a604700b0029b0789802amr1074656pjm.31.1709962952380; Fri, 08 Mar
 2024 21:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse T <mr.bossman075@gmail.com>
Date: Sat, 9 Mar 2024 00:41:56 -0500
Message-ID: <CAJFTR8TbFFHSxX0hUbiACcY4uy2-QppfT0CgBMjico=Cr1DWZg@mail.gmail.com>
Subject: Questions about userspace SPI async IO support
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

As far as I know, the SPI userspace API has "no async I/O support;
everything is purely synchronous."
https://docs.kernel.org/spi/spidev.html

I would like to add support for userspace SPI async IO.
Why hasn't it been added?

Is it not as simple as adding the async equivalent of SPI_IOC_MESSAGE
to ioctl, or is that not a valid way to accomplish this?

Thanks,
Jesse Taube


Return-Path: <linux-spi+bounces-4209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2368956100
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 04:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0C01C213D0
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 02:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594F1CD37;
	Mon, 19 Aug 2024 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMABgn6B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6512B8B;
	Mon, 19 Aug 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033592; cv=none; b=WG2ArCZSOGSCe7y+aCEFky/z1tVyPxXFf8s4Sr9XO6mv63OCTns88YVb1rym30WRAhAHZyiDxB5+XGNdp1Qh2M8LrwaQAZhKOP54Gd4ZIxmCC6Pu8tpp2U+cnwGCo5Xv08RRE5f8WRI/PbhEY1ehBdiO8nEZzbagcxA2MqxlnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033592; c=relaxed/simple;
	bh=KYkIAORlvtSr3a3QBZAHWCNrfGBZfFZZxHsbX4YiEcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj+r5m/h4d+FGSdo+UscgwLVlvs9U6/V9gDFDHbOiDd+gu2HhqB3HR+LboojSjzAgArTQoMqjIbzoe/lY52Urwtx0IfXRplcuiB6CnytWDiI7FbrftS5MxsCMpRRnccc9RLdd29VdDU8y5/fkbVW1XnvVi6QxkC/KqwGA0Q7lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMABgn6B; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f51551695cso1378109e0c.3;
        Sun, 18 Aug 2024 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724033590; x=1724638390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr4OmP8xGGsL/1Gww/d2oUqKmeZvZ5Qj0+OKcgxTVv0=;
        b=kMABgn6ByPnKZq+LAYKARZML2pIBL/4KuuoqzjF2/F0MJ3wDPAtQFVvPkyq75/IcFj
         IP1q3pgL5Mb3U+Fu3uf9C/EPoQdFLQbgV/zhPZUsG9UVHFTURrFDGBvB/naOjxM4dp7A
         8dcdKQB4O66E1p6sn1zlR510ZNSNGBRPa5rr/AZJqT9Rb1ig1TNNI31fqdVF/Cft9NQS
         l8MkBVjgOjEne//dqcdiHh9ssHHvp/zq++D3v266tDNYbuWgYaiIBE2z6MECl4fuaM3e
         12XT7Jt599YFwdqwBaIOzEGcx/my2O/rSxhGX11UEupXUKOiwsPjjAlVtdHV9fkSLRVh
         ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724033590; x=1724638390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr4OmP8xGGsL/1Gww/d2oUqKmeZvZ5Qj0+OKcgxTVv0=;
        b=gQmvxXQ8DSzc6n8HeirSTljH2XJg377DLxS84wiGB4dAc5MQU7zkH2RyE/jkhWMjM8
         htNceMeGsUPdpZRLkGokIVMUxfDX7GxuakCjzNw6amRwjqWVKQc1I8bTSibwIu2DzLrR
         ch0GvyL+MOqt37L8E+BrEsM7bntPVlcR0Cicb4qLlavDYHIOocPzfU+bUBc8xtfQuuPB
         TRLvfz2mD/HAQ8Di9U9Tchm4K8YLgqXrFvUKLEoFIYhDm9P6tjfFtsUvQsmKDfdkEoqt
         puIbHn2k2SKO92TatZD2rPkiK/E2YWO1zfHoxrN5DcFHKWybf1vsCaPqAe9n/h+oNwet
         KooA==
X-Forwarded-Encrypted: i=1; AJvYcCWsnCmUXpNZzlRyT3er+k+D7B3Qd8kvaxUqdPh1ofTbJQnbMycW8NRBuk4DiDNrw+U4pOl86Un0ZrRU@vger.kernel.org, AJvYcCXtW34FhqSkOzpb0Gep4RYbfOKpMnHgC02L8hMNnOzfMEOZB+OPtcIfW9ZXyYK29W1fDXa7tf79cSo7CqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+36l4jmlGJr4GI4tuvGfPg9hRm55/FBg2aoo0EUtomKA1cal
	bjQ+0rKe1xRlinH2rANpGtXfKm0wSwrSofOaoozEwMCacdo9oMZ6AOr4JvDblidFo583AuqN44r
	WgsbBILGSzHvYaX0O9RZeSuVmHamMuKCd
X-Google-Smtp-Source: AGHT+IGXzFITY/wGSHK7MzDwixkGnmeiR+eN9HqKUVlrIOI1KSiPZpowvJviUYAZ60XEPwq8T9vGUFKP4SA+cu9ddnw=
X-Received: by 2002:a05:6122:a0e:b0:4f3:207a:c664 with SMTP id
 71dfb90a1353d-4fc84bd0a9bmr6940618e0c.14.1724033590145; Sun, 18 Aug 2024
 19:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
In-Reply-To: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Mon, 19 Aug 2024 04:12:58 +0200
Message-ID: <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:13=E2=80=AFPM Vicente Bergas <vicencb@gmail.com> =
wrote:
>
> Hi,
> i am a user of the CONFIG_SPI_SPIDEV device.
> It stopped working between 6.8 and 6.10.5.
> The SPI bus itself reports no errors to userspace, but no devices
> appear connected to the bus.
> The platform used is RK3328.
> The only spi-related message in dmesg is:
> rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>
> Please, can somebody review this issue?
>
> Regards,
>   Vicente.

I've tried to bisect, but there is some strange behaviour:
The message "Runtime PM usage count underflow!" can also appear on a
good kernel.
In order to have a reasoble iteration speed, i am updating the kernel via k=
exec.
If a good kernel (6.6.30) is cold-booted, then, all the kernels
kexec'd from it work too.
If a bad kernel (6.10.5) is cold-booted, then a 6.6.30 is kexec'd and
then the same 6.10.5 is kexec'd it becomes a good one.


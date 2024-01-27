Return-Path: <linux-spi+bounces-893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A774783EC62
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jan 2024 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C147D1C21CDC
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jan 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2BF1DDFF;
	Sat, 27 Jan 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g53Vqlw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023431BF44
	for <linux-spi@vger.kernel.org>; Sat, 27 Jan 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348895; cv=none; b=C64+mRqeyQFq9KfAoev+ftvFf4KfnMB7be2kRH1qulaHEd4FLZkVg8AOv5Mo175fDBazr6Jau0rZEWShllGfcdJlIw3HQA51RZGBdPvSm/acechm3jcRou0iZFAQgxyRtaJfsMGZRtietPo7/zpVKGZ8mMG4IRiQECWNaSUyEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348895; c=relaxed/simple;
	bh=Gtmc29fRs1fsU0HJgKChtcG5Of2c7B0Vr4bREb3YRJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cd4C83IhUjj3ew3UeoZLRW2kahzkhOM74/fKnl31XhaKdrn5Ldpitx1WYd2W710lAMKgv8nbrU0LYaEJnIqI2x8jdqRKQslVcn/iIKQeu+KVh49q+K2ODRs/yB5DK1th5cu+c4q37Dx1f0/Ftx5Xe+fXA3LlY7F0K4+Eeiw58Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g53Vqlw+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so384861f8f.3
        for <linux-spi@vger.kernel.org>; Sat, 27 Jan 2024 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706348892; x=1706953692; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1/0KcZ7chpIg7ZK67GGgrTgsakAyIEydKof3WPwPz4=;
        b=g53Vqlw+XMqKPh7bDfioIAqCoqitQQbKn5oO61oThCu4YiXO8OLNPiGZ17jPdbI9Fr
         E+xQARAMUUecOUOuANMh0XK/TDuBRULwzbHBfEUamE3LpV8pHMd5gj+3JNhehN6zwZPO
         T51GTIrC1B67S7snmyyuz05UT+KWM8IOEW/XjZOp3Wz9h+Z8EbZA3oPpB6aWJxRSXM6G
         mjeDHdBpUKYNu2TSd5EgnBTym/+u9vIiZ5J24YgUO15zn8dWcO/7FzF9kqx6XhsUDyrw
         NpOsVL/6H/UxDf7EvS+oZ4OKFUoRFdLkpDDc1RTeo6XlFTjHhzD79alqrBqm+Fme7mgT
         Bksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706348892; x=1706953692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1/0KcZ7chpIg7ZK67GGgrTgsakAyIEydKof3WPwPz4=;
        b=anNn9bGT6X+qnDsWB4HE/0iNstGeuT0jmSor42Ej4Q6+vjdP+mS4LwMCbmHEWiiAsc
         3KKV+B4h2sq9Z3YvvQ2hWCrWPGhcAY/M3vbp7So4+Zv2uoQl9INt5PLGkN3etz2CntoI
         12SbfthI67NhW2SX5jYR4i91BjywcJuNSqEwrkhe6Xvj5Jyg8SVyIeHAS2HnU5V+y6WL
         xLh6AjSdjUXtGByNOVdTB7BEOgDUftp3f/fWnli7ZwE9ydLdWZHxQEYZ/fTaPWL6RWPd
         OGHOedXujsnaBI9O9xoiD7erJCORlIt4qkZJuqDcQSxBJQHmflCPt9adJXF61XOu4lS9
         YLpQ==
X-Gm-Message-State: AOJu0Yzmlfd4pE2UWYmQis4d+2Nsv/7JhWgTuiR+k+wQ2JN289OgRzGS
	6Yz7JiV7nLMpZMJV+rp7MJxSy1gnSJiW06O4/ya78Xn7CuaPI9To+6pB+e4Sn1FQeg==
X-Google-Smtp-Source: AGHT+IGn/64q9Da4qhAUIbiYIXYmy+UOZee6/cIS9YywQm0IGIQe0SJY7U+xFJgA77ud3L/I5i7ORA==
X-Received: by 2002:adf:ecc5:0:b0:33a:e4ba:16f5 with SMTP id s5-20020adfecc5000000b0033ae4ba16f5mr429857wro.3.1706348891904;
        Sat, 27 Jan 2024 01:48:11 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b0040eaebc4e8fsm8120643wmo.1.2024.01.27.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 01:48:11 -0800 (PST)
Message-ID: <ef65935fac5c09c9eccb89604fc8af504c886f5d.camel@gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-rockchip: Fix unused chip select line when
 using gpio cs
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Sat, 27 Jan 2024 10:48:00 +0100
In-Reply-To: <fc9519de1d278c3f0f0ba8a9640b0499ae2bedca.camel@gmail.com>
References: <fc9519de1d278c3f0f0ba8a9640b0499ae2bedca.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 20:47 +0100, Luis de Arquer wrote:
> This change allows the DT to use native c1 for a device while leaving
> native cs0 reserved for allowing gpio cs operation
>=20
Actually, I think this comment is the other way around -reserve cs1 and use=
 cs0 for device.
Before, it was using cs0 for gpio operation always.

>=20
> -			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
> +			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, ctlr->unused_nativ=
e_cs);

s/ctlr->unused_native_cs/BIT(ctlr->unused_native_cs)/

I mixed up cs numbers and bitmask, sorry.
I'll fix for v2

Luis


Return-Path: <linux-spi+bounces-10329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030EEBA7177
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16C83BA607
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6B21882F;
	Sun, 28 Sep 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5pMhPcv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0F1F7586
	for <linux-spi@vger.kernel.org>; Sun, 28 Sep 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759069003; cv=none; b=Z9BI0ubKHxriEwDG7+EtKFnW8qhNXgJG70dOcgBUSF+eFSkPXQ0T4McPnmrt3PK+Otx/pd0HSwTnHmi6P0YO/WgdSrUMbv4hGVX5bLHwsdL6LCQB6soRjyt0gWpJlSW1FnbI0f4ecH5f2MLRaebnfFfzy1oLzzyoWLsfUdB0H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759069003; c=relaxed/simple;
	bh=FmwvbHDppjU9CvYc2ySBEPJJrA8QuBJrnaeLbvaNeq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAcqd3VLVplB1OmQcCF7U9DscBaz/kmuSsqR8nsbz9jsGdLgHhkXVjjS7gvoyuxS10h7JQOj4ULF4zlSDvjxjNu+2qqZEA/nEed8u6sQocfLe0QIm3yy4C3w2RkaGVFZx5N91twXhtr05DCFBdfBQnDoyj6UnVIAglBmEtNcijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5pMhPcv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-271d1305ad7so49932525ad.2
        for <linux-spi@vger.kernel.org>; Sun, 28 Sep 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759069001; x=1759673801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qS561fu3xGPohq7c2b6s9Kqxn1syIAU/WENOzQp7H2A=;
        b=i5pMhPcv2txHGkH1YtzaqUjxI6TKbfbfQaM+KOuZiwsetEjjnW5EfpJ6ly+tJaWx6F
         Z9kl+Isk82Ajz+rI3D3D1gveiFFbaSgVm/ZwvaMdMzT1k+kXZZMNaExt8IhhrUmm8M9X
         v8vCv81+Njd3cSpNgvAOk94SRWr45YBIPVrNRl+ScVjlLjcc1+jsaYuvOfSVM+E8sydO
         I520epSXPTuWD/Zi96mrxzlxqlyukGF2A+FF/ut2ZHfE3ct8Am5LoMRFcnpOVCkX8nYB
         9xbW3nT4dLTFxGtgfhZSTtgNdZPNRP8GWLNVQADu4gK2A0KWoYHhaWngGxAqVjtaW48+
         7JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759069001; x=1759673801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS561fu3xGPohq7c2b6s9Kqxn1syIAU/WENOzQp7H2A=;
        b=mL9NgykjvVdEFJrriym+jfpn7Js22ZWgmwIoAF5KGeRsbzugMsVahiWi+0/uf+U1Mb
         1NOobN31ePqcUHV+E6YHxcpIS1+4VtdTs/pdwT/6g0E6Tv1PUj6B2WJjQZQf1dziVCnl
         j2hfODTk9LDJPYpUGUNu46TpJrzFYDnomXd2IIBaaGuQhIeoZliIQlNJDVyIxZ0cG/hY
         cKK3vxavBawQU7SueFjPkLaICjOVOdTLVOvgrJ+DxEAhFCfkXWbhO2Dit2wqKu2Tihlw
         FQF6sP6pOT7ymCnRk2dkgrlA/Ak/BsSoiTSyDkrcbPC1J751jaIiiX4qZRXUh8/62WZC
         bxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlhQ/rMBnp5C2bvefh//FH0oOCOpoHSFijWA8Uz1J9xf8XEIiMXN90tQ8q7aQfuadZqnlvg+rUlQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4Bxr3lWw+QcRn2zAZMLD1lsp5P8hhaB9QLYxDTYn+O9erB4z
	i29QeNcQCaKQfd5ZBFzGxuN3xGNRhnJTaEBL2psZ4+uhXJa67Enw6Tiy
X-Gm-Gg: ASbGnctorlL6uNpLZzgJ8d6fLvOe0ISvBaF2T/6ohqN8+F4Olqjo0IgP8N8Gb14T21a
	/cQ1VT6iF5fOXdL9lOmpYX8shiBV2k7QJ1YLMyxnyq1Im9XFPKJ4ScinKlITLBtttAr6B0Zb+Y8
	tSXNBIs4bwzp2LkCU1FyFL9yPigOAqcAny4a5DGYjwVR5nb9a7ubKRAHpeNfzhh+X1+G4BJREc2
	u/i557o6pj2WDTySj4D8z1toJk3VcSYtyvFiS6dSJI4jD8pA5/DW/b58fpreJ6xtI2FAR7crAeC
	r2/ZAim3hpnYk/XIGtlwnfV6ZwidlCHmTmgBm+KyG3rbkxZBg67LKpqcklyvWWoREBBwvMFpKN3
	MQ4ICAa9b9oJDjgV2POKOAWeOPSbuAuiyCy5Mj5qpsg==
X-Google-Smtp-Source: AGHT+IGylC8pdXw7Cs1te5retyIezZV7wuMBKjmnFoV675Y5zYlzg5VisBqeLGQ9FgxZdW/sAWmpqQ==
X-Received: by 2002:a17:903:946:b0:271:49f:eaf5 with SMTP id d9443c01a7336-27ed4a30d16mr151724525ad.30.1759069001499;
        Sun, 28 Sep 2025 07:16:41 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6ae5742sm103357305ad.150.2025.09.28.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:16:40 -0700 (PDT)
Date: Sun, 28 Sep 2025 11:17:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v3 4/8] iio: adc: ad4030: Reduce register access transfer
 speed
Message-ID: <aNlDfJvyXjnfINy3@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <fd505d37aceaafd6b20626bfd3f25c47db1fb004.1758916484.git.marcelo.schmitt@analog.com>
 <20250928105316.782d076e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928105316.782d076e@jic23-huawei>

On 09/28, Jonathan Cameron wrote:
> On Fri, 26 Sep 2025 17:39:42 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Configuration register accesses are not considered a critical path in terms
> > of time to complete. Even though register access transfers can run at high
> > speeds, nanosecond completion times are not required as device
> > configuration is usually done step by step from user space. Also, high
> > frequency transfers hinder debug with external tools since they require
> > faster clocked equipment. Reduce register access transfer speed.
> 
> So making debug with external tools easier isn't usually a justification we'd
> make to slow things down by default.
> 
> Is there another reason for this being useful as opposed to not a problem
> to do?   If it had been done this way in the first place I wouldn't have
> minded, but to make a change I'd like either some others to jump in and
> say, yes please do this, or a reason beyond you are using tooling that can't
> cope with 80 MHz and don't want to hack the driver when you need
> to slow it down (my tools can't cope with that rate either!)

Main motivation for this was a suggestion from David.
https://lore.kernel.org/linux-iio/30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com/
By the way, if he agrees with, I'll add a suggested-by tag (if we decide to keep
this patch).

Reasoning a bit more about this, lowering reg access speed may help debug with
external tools, but it won't help debug transfers ran by SPI offload hw because
those transfers will be fast anyway. Maybe a more relevant potential benefit of
lowering transfer speeds would be to make it more "friendly" to slower
controllers. E.g. raspberry pi controller reaches 32 MHz maximum so, unless SPI
core can adapt transfers in those cases, it wouldn't work on a rpi (if anyone
ever connects this to a rpi).

Me, I only have remote access to a setup with adaq4216 connected to a zedboard
so I won't be connecting any external tool for debugging. 

Another thing that came to mind now is we could just not set speed_hz of
spi_transfers. AFAIC, those are not required.


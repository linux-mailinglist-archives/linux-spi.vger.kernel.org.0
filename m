Return-Path: <linux-spi+bounces-972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09400845C11
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 16:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F75B21334
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565496215A;
	Thu,  1 Feb 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbIzhgLp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324735F489
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802492; cv=none; b=rMc8viAkuU2IeGC/8RavrZxJ6wkfVqVQ4I36fHU23gzDeOzn2nw8WNTc0qKLOmEWi6YGqNWosUHD/tLfPLL08EmonzcIGChsUydfjfb2PtGlOYx7YHI7oOiWFJIC5fyWYnYc1UcqveLc+Y3FNNUjbr9SxZh6e3vuXG5i8Kg2xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802492; c=relaxed/simple;
	bh=id6J3Cdah8jvslg1QrGcgzsC/X2JHmHmGKSbDMSsEbk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f3Rc/rIbzMIsnw/bvCXJQfEpp1sTHnDw55kRveW5ZPNH7E1iCtMzrJbk4mG0JhFl+LHRcgx7Hi36J58508lgQKZHFdAJ/sDzLVwDHmFYyh6PAx6SsQo7B/FgaKR8KdKtpNbJ7Lf+l83DibTg8YaEwdEe32yv0T4hxiyiFkX2rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbIzhgLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237EC433C7;
	Thu,  1 Feb 2024 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706802491;
	bh=id6J3Cdah8jvslg1QrGcgzsC/X2JHmHmGKSbDMSsEbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dbIzhgLpUu4cbJMkZ0C9hcGjOvzWU0SNikeIjwAkyy9HqZ30gsabUPaezCHWsY4l+
	 FY8PEEiOlIwKWkp2AYhAd8OKUQE7H44jHOwa43TaHgGbjyQyfo6RFkb1q1n3LpISyB
	 Uh60hYwkQDTyE8YWAmIeVJ5Ag1Cr+y7BOTTRvs2bAyLwsiPnalIF4RqkRieyhMy0dL
	 2jYEMeGumZHhnC0xcJADyTrc1EoyOaR6LCyf/Qt2+DMtxW0Ep8fh4WifBt/4nsLq0s
	 QSwQSADHyFeYHAz6GFvABlbzS/BBgdSJoKZjm35kKxU7Fdr4LH4zHqOdGCgMSmzRfh
	 eRP4hpp6iO7Dw==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 16:48:06 +0100
From: Michael Walle <mwalle@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw,
 jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 6/9] mtd: spi-nor: add support for Macronix Octal flash
 MX25 series with RWW feature
In-Reply-To: <20240201094353.33281-7-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-7-jaimeliao.tw@gmail.com>
Message-ID: <f1ef9b347b5b25491cc65a8262de7386@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> From: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> Adding Macronix Octal flash for Octal DTR support.
> 
> The octaflash series can be divided into the following types:
> 
> MX25 series : Serial NOR Flash.
> LM/UM series : Up to 250MHz clock frequency with both DTR/STR 
> operation.
> LW/UW series : Support simultaneous Read-while-Write operation in 
> multiple
>                bank architecture. Read-while-write feature which means 
> read
>                data one bank while another bank is programing or 
> erasing.
> 
> MX25LW : 3.0V Octal I/O with Read-while-Write
> MX25UW : 1.8V Octal I/O with Read-while-Write
> 
> MX25LM : 3.0V Octal I/O
> Link: 
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/8729/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf
> 
> MX25UM : 1.8V Octal I/O
> Link: 
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/8967/MX25UM51245G,%201.8V,%20512Mb,%20v1.5.pdf
> 
> Those flash have been tested on Xilinx Zynq-picozed board using
> MXIC SPI controller.
> As below are debugfs data, the SFDP table and result of mtd-utils
> tests dump.
> 
> ---

What is this? There is already a "---" below.

It goes like this:
[From:]

Patch description.

Link:
Link:
Signed-off-by:

---

Test data and SFDP dump

diff --git a/drivers/mtd/spi-nor/macronix.c 
b/drivers/mtd/spi-nor/macronix.c
...

-michael


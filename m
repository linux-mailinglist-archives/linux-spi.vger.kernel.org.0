Return-Path: <linux-spi+bounces-6086-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16E9F4F80
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BC91882CE2
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0AE1F7075;
	Tue, 17 Dec 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rws32A+O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3F1F4E34;
	Tue, 17 Dec 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449549; cv=none; b=GdBgRM/f/T7CZ+ehXII6cZ1+6RutG1+aqaEegzW7KyNYhNzG8FUsAfyYAoJARyELvNwZybcOq4fpp8wZGV7k2hbTQ/UTlp8LQQDD2UPBMoQCTIUwHVgpQlHyA7nRT2FrP7ruwiGP2idKaEGQDQ3BUJuMFFkjTmlZ6xMJpItUdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449549; c=relaxed/simple;
	bh=af4QqSgGILbUAg8428/Qr6a223QfoUxIl2tLwgkLpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ0j09oULzckuyEgY10uH2neQRMjGiBDQI+nJK3MBNvBBfb/mdmC+havjn4FF5eLi88xhnj3nSNwc5IEv09NopeRf5pdu5IVLNG56+C2pUsxtalybkEs/mAZor54kuGWZEaS0MdalQiJEIzS+eO/u6AFRQk1Wd9WOjNd0jlJwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rws32A+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7E4C4CED3;
	Tue, 17 Dec 2024 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449547;
	bh=af4QqSgGILbUAg8428/Qr6a223QfoUxIl2tLwgkLpY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rws32A+OLTQQ0rqwZ3tg5Y7mD8EN6ajq7r2isH2tpPHV21AvK8ObylIfn4pRFPG9+
	 KCQS5xa6v2bR/JB57oMR+3DvofDhfuwZAQXdmFNIiaf/xMMaYlFAZ+FtXMz2bIJS++
	 7Ov+b6y00YiJVtxDt89Zg8UmaYsxqB/0VtX3lUR1jiXlN4Tc7krhITjTIgJPW9pYt9
	 s47yTRssIotXXVdgREsxQsewjKj6Lxc3Z25TIpy9mC3oP4mjQ7gEj/TiDuM1rct5E7
	 htxML8bJDvP3ap2deC7PsHvKTDw6AT/b/Rsk4p79wUR6rEXiYPhdQVQ4ho7wyMlo1d
	 PApEZEiyEv9ww==
Date: Tue, 17 Dec 2024 09:32:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: javierm@redhat.com, krzk+dt@kernel.org, linux-spi@vger.kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] spi: dt-bindings: Document CS active-high
Message-ID: <173444954482.1831986.10950873767411380900.robh@kernel.org>
References: <20241216095739.27320-1-ikerpedrosam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216095739.27320-1-ikerpedrosam@gmail.com>


On Mon, 16 Dec 2024 10:57:33 +0100, Iker Pedrosa wrote:
> The current documentation does not clearly explain how to invert the SPI
> CS signal to make it active-high. This makes it very difficult to
> understand.
> 
> This patch adds a simple explanation on how to set the CS line in
> active-high and adds an example to make it easier for users who need
> that setup for their SPI peripherals.
> 
> Link: https://forums.raspberrypi.com/viewtopic.php?t=378222
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> 
> Changes in v3:
> - Use subject line reflecting the style of the subsystem (Mark Brown)
> - Change compatible display to an existing one and adapt SPI MAX frequency (Rob
>   Herring)
> 
> Changes in v2:
> - Include header for GPIO_ACTIVE_HIGH (Rob Herring)
> 
>  .../bindings/spi/spi-controller.yaml          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-spi+bounces-7049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9948A5452D
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356207A7C62
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F7207A23;
	Thu,  6 Mar 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srujC6gz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCB207A04;
	Thu,  6 Mar 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250528; cv=none; b=HUustnFpgRExg8t7eEsKIhLvOsdoo2pjyl+AKdknfE+hzLW+kcBapoU4BH2IJf8BTrZzp2OmdB63LPXt6OMU7ynbZlZIpSi//tgBtoTbmf8D5qAT9/3Ud3tDH18Dkc92WiUPJXPbKCmgdNCiwA+gkQubqmh/SYhqolKdyHkfPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250528; c=relaxed/simple;
	bh=ygirwWVr53tOwDuoXkCCVrhpZWtPE5YuXggrt2tnhjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxae4e2Mj6+uXNe8U1nf3Q1RXVqWGJFJAZvOA42bYESwsDaHKPVW3S1ctrK12HNek+qaqJCxWdwViKLu9e4mDv4TlL5lYn5S3TnCZCUiZrn6rYCbmaU7v7WZLjwyaCKzN4B/wTajWvA35yoRNWeLFZFRn9C4szk5XZ2YEjUm740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srujC6gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D144C4CEE0;
	Thu,  6 Mar 2025 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250527;
	bh=ygirwWVr53tOwDuoXkCCVrhpZWtPE5YuXggrt2tnhjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srujC6gzEXakg6j4HqWTFm5p1Tx2WSksOBJVzFMnjaEnL9qV0k+zycQoyNqebvLZw
	 92mfngdK9wL/jiKHoh6S2nIiIaPayE2zidQsjl3x7XmbyfhK+2vpEwC0ZzuGK8ZqG1
	 tpVfUvGBNmpFfR21d6nydl0wnWNus/2FV8oAFmKgRXLkZgwUTQgpX0v+MJptulygzE
	 zDun1ck1KH1t3fSsPWwt/VRjUmMQUspjj8IpqkjFbVKf9HcZpJzNJT6sL+2zF5fPy9
	 pivLrFo1zjA5ipWSzVjnX2mL952gTuzA5sMS4gWqinXWLBtsZufVFU142S2/KwbRQd
	 zCRJgrfy+C8HA==
Date: Thu, 6 Mar 2025 09:42:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive
 regarding what this controller is
Message-ID: <20250306-puzzling-placid-guillemot-3ba7bb@krzk-bin>
References: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
 <20250305200133.2511308-2-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305200133.2511308-2-miquel.raynal@bootlin.com>

On Wed, Mar 05, 2025 at 09:01:31PM +0100, Miquel Raynal wrote:
> Despite being very common in commit logs, SPI NOR controllers simply do
> not exist. At least, they are not as specific as the name implies. There
> are SPI memory controllers which are indeed "specialized" and optimized
> for handling "memories", but most of them are just generic and accept
> almost any kind of opcode, address, dummy and data cycles, making them
> as suitable for NANDs than NORs.
> 
> Furthermore, this controller supports any kind of bus, from single to
> octal NAND, so make it clear.
> 
> Also add a comment to mention that the initial compatible naming is too
> specific (but obviously kept for backward compatibility reasons).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



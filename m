Return-Path: <linux-spi+bounces-4737-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649779714D7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AB92836DF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB801B374E;
	Mon,  9 Sep 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3b4M4HD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3DDF58;
	Mon,  9 Sep 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876439; cv=none; b=NSV/RAVpA+n6g7oxyfcaOI2afc35hld5hr57Oc3o/SxopRu4WoBxy2wyC1siELdv5dvaajRzGQ9CPqQurfFYmvCbrHP0Le5JcNoylJu0cMXZylJu9XAStTQp1IkV7nNVHARFDFhgN3Jr/58hoVXdfyVQPavdQ53aWbBOe3G1tfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876439; c=relaxed/simple;
	bh=XHXlbPbsks6inwZT3SBeKc3Emrk6/RBcR1LyiF7/iQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYKrynbd/rQZ+xFApY7T0W8jtZ5wlqJUPFeZWobYpNjNv4knptH14TJg73EJkDOcpEsVLPzNrIjwCFPsBWUO+SKNsxt/mG/sTZRQeklygcD/jJYGq7wTt1SIivP78zh5+TS7zYcxfkpbjvlIFfHFsfEcKFNR2kpyW7aCR8PiSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3b4M4HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E07DC4CEC5;
	Mon,  9 Sep 2024 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876438;
	bh=XHXlbPbsks6inwZT3SBeKc3Emrk6/RBcR1LyiF7/iQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3b4M4HD9I3KXtCYLhNU7FgcE5MJX3gNrHzMr4Nx0znE7XoAlP/e3E+vE/+SMslzD
	 B6GqWxKxigr/HEZUBf8L7KDOYMnYkaG9YSzcmkNcHHp8Y/DQ6j76iDlZZgMnaCf5Vs
	 /55Mi9PKXr4e3nkwnB5LGFBkA68mGZy6LfJwJGScZMgALUYPmbAcs1fY3NBOdXZte1
	 UsPLrkvfDWSk3keBW+pkiHbbn919MwNrLos9UqzGY6s++M8CGQOEVOW3cYImaH8G6q
	 U+gBvx5sXNkw21p03yWD1dy4nf+jkmEC2HnMjHs63KF+o+h6vsQoZwkQGiCtbQ0I0V
	 PwqE99YVWxFjg==
Date: Mon, 9 Sep 2024 12:07:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 2/3] input: touchscreen: ad7877: add dt support
Message-ID: <bnndfn3trqenvxd2qydlxadtm7r6kznvydekhukbfii32mwgz5@xpda4cqacgok>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
 <20240909093101.14113-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909093101.14113-2-antoniu.miclaus@analog.com>

On Mon, Sep 09, 2024 at 12:30:12PM +0300, Antoniu Miclaus wrote:
> Add devicetree support within the driver.
> 
> Remove old platform data approach since it is no longer used.

What is the point of the previous patch? How can the device work if you
apply only patch 1?

This is somehow odd split...

Best regards,
Krzysztof



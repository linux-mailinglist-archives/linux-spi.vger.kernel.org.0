Return-Path: <linux-spi+bounces-6191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35209FD18D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2024 08:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D432163D60
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2024 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948614A0BC;
	Fri, 27 Dec 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTfgVUPG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E060149DFA;
	Fri, 27 Dec 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285402; cv=none; b=S3uADjYTyHG3dfivL3iuniKQrN2A+g0B1/p2thhxQ0EG/ufjaHZc0L+fnaqCAmJhfKqJ8IwLLmaC7T1hC/MKWqHfM+OsimKwV/nwKvgDt+2pQa/sFiecFHpuNeJzD5/tmKJEuxO14+oiQeVq1IWWyUev4orGD/0V8WpyeU2cqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285402; c=relaxed/simple;
	bh=UpI1kDIDP+9wxN+lrRFVGk9iCMxhSweHXt23HZnkQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ9HhxtihPMq4kSnwsgWpnb/BSYqRe/y8fwr8TIuhkJfNpF8MbQcj7nkR1xfxiZhVYF1oq03+5tXmSCp4Y5S4UgSwoB6CwHWyWZx90HQOzXL72WgBSTmEXbnsB90z0MAiKkPPMec/58LFzoOFVv2PMV1NyqZpJJ4V6UAAq8Fmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTfgVUPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713DEC4CED0;
	Fri, 27 Dec 2024 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285402;
	bh=UpI1kDIDP+9wxN+lrRFVGk9iCMxhSweHXt23HZnkQJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTfgVUPGvILnEsFCcoRqMLWP67xbeZfQ5AxICwJM5p5gNXIpmy6WVReFEwXMO/fim
	 Vk5DjqvVruX6zk2KA90RmE9AoWfZyEUl9n45OFMELB6hN9dF73mcPN340QRnql0uGn
	 suF6yCDL5bEhelQM+6X5YmeciVuYBwmlrut+IOjiT8Ch5aAU684PnzMgUw6WaMBTSA
	 3yvrKkqyHFftlk7Bo3Q1qRO4Vk1+ZfjdhULbrNJpPsy+je2xZYrE+B95NtEfbhOfev
	 XjBnFqvJE/izUqZ3ctWXFeTzpX2///ulmouwrueliBkrqOArupEQdJxx+/321v8yM9
	 PG6ttdkzMmC1g==
Date: Fri, 27 Dec 2024 08:43:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/17] dt-bindings: spi: Add rockchip,rk3562-spi
 compatible
Message-ID: <bq3jrw7r5wfzffosfh3eerngvqvd5lc6ilrnu6fstpxx5fmzm5@bdowzwie5qae>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-9-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-9-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:49:11PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-spi compatible for rk3562.


This we see from the diff. Say something not obvious. Where is the
driver change? Why aren't the devices compatible?

Best regards,
Krzysztof



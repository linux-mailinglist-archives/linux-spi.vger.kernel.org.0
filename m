Return-Path: <linux-spi+bounces-4870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8797C696
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BFA1C23B06
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C7199FC2;
	Thu, 19 Sep 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4CzLrWH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D43199924;
	Thu, 19 Sep 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736987; cv=none; b=PgYBTju0VOTqknBctSt9appB5ULg5GeXAIPB1tBHxlX7ey5eSZ0JKn3CC5UaJ7A2GmxM9Sx3V08mDvwoYaZUddO3E8HUNSgC91Jiuwova+5ZcBo4Z1cOZIRb13kh0bw5n853t504VjyMLi+lybuoGJKzwDfIkkaruKbRogIO6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736987; c=relaxed/simple;
	bh=kB/dNdtwbCvdKRytgSgOnJ7fvVihQkMZJrYF4nzk3VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzvUVVH8CNL4pRvRIiF376a41unOih2W0YvpePG1jQ4MBfU5k5Yg1K0TTqEnOz7HCDIx3zfJQdWbBp628jLGGGuDgJ+Wh3euvdUtUHkuQAsXVREubO6FtdT2+zGbYmHaioQBn/z6bt9l83RQ3WoyGwT0ZCKsFemqX1fmEB6TvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4CzLrWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575BEC4CED8;
	Thu, 19 Sep 2024 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726736986;
	bh=kB/dNdtwbCvdKRytgSgOnJ7fvVihQkMZJrYF4nzk3VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4CzLrWHN5RvAhgNxGV1u8xezSa+F7pVSEDrVOSxrjxNlsou2GzpZj2QgYAtYMskQ
	 xcOxPgptz6ToJEehY1d++Qs1wRLK/eyJLTbVvmvOJiwnvzkwVHFlTxZ+vRuQbXcF0K
	 ksHqEeB+3+RJ/S6lILZ7opc7TBzgnQDaJm+nQOnnPbqE0fI91BIKsVKETx3B+pEE6W
	 A8nTLSKU8i/paJlZ2PQj50b8eUblblttlIgKN+UydZQgY4zqDvzUa8OI1z4wi1HfI8
	 vHWO+1ebPmuR0x51L55vCDdxKSa7yha39JbsKbm6Cq5YF3eSHs5fjzaZcr2a920btb
	 MbgA4sdU5JwQQ==
Date: Wed, 18 Sep 2024 18:43:30 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 09/18] spi: spidev: Add an entry for
 elgin,jg10309-01
Message-ID: <ZutXksJASClU5gia@sashalap>
References: <20240910172214.2415568-1-sashal@kernel.org>
 <20240910172214.2415568-9-sashal@kernel.org>
 <23411f79-ac68-419e-8c28-640dc3df1e40@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23411f79-ac68-419e-8c28-640dc3df1e40@sirena.org.uk>

On Tue, Sep 10, 2024 at 06:27:28PM +0100, Mark Brown wrote:
>On Tue, Sep 10, 2024 at 01:21:54PM -0400, Sasha Levin wrote:
>> From: Fabio Estevam <festevam@gmail.com>
>>
>> [ Upstream commit 5f3eee1eef5d0edd23d8ac0974f56283649a1512 ]
>>
>> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
>> The marking on the LCD is JG10309-01.
>>
>> Add the "elgin,jg10309-01" compatible string.
>
>There's also 5478a4f7b94414def7b56d2f18bc2ed9b0f3f1f2.

I'll take it too, thanks!

-- 
Thanks,
Sasha


Return-Path: <linux-spi+bounces-5155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66B9955AA
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FF31F22029
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4120A5F5;
	Tue,  8 Oct 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tz0ZfTzG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF020A5E6;
	Tue,  8 Oct 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408741; cv=none; b=UyWSHMe/thhbdxLoh5ces6f74vSxkBcBF9DWLQt1UKbwjBzxdUpNWh0e1aYm06EVorFFbYW5ZmwFwCuvhdqBXeo86dgJXuRtoFv8mhD3fHE9R36ZhehE9a71ScGYALciFioB6jyWSnzNkRkjtnmq7VhVByQSXm3SpkfyH5vV+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408741; c=relaxed/simple;
	bh=+6OIhpZO0dz3NCshNqbYJVlqgYrOywulWtyqx0v3EwU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lxmCi2dmFArLq4mBjZtV4zxa5tvGXsfd++04VaB6F4ISSsFnbPS7ZzARawno9/UuC7s625U52xZuP4hp5EvXrPyAwArq+ZceJkU9rcEnVtNpmEcYxpr+jMemw0qBzqcUqVt+QgKxPJ/BjlRXyL+T3q1GMXq4/iOYlqR+mEO3oQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tz0ZfTzG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728408738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAixrU7GSsMe+W1yVXLY+I0OJDCjyT5Uy/xMHz0imeY=;
	b=tz0ZfTzGAdexz0k7aapj9QSybaLydKJHKWPqt43zHC5q0DxE4HoLkX4cDboT3jf2YuSqHF
	xKTYPoYZaTHB/O7XQVzISZx6L9BAf5z4qcYpKAGhmaTfFznJZdkk2lHr22UhIQXvdEnqPX
	Z/EkqrwKuqtov1lPA/i70zGo6WrNqpHygFltRiHspypx5ZALdjAKn2ju4jWtiDI7Cvte0g
	TVBbf9uguTPCCgmzy1WneWtC9w0WpFIDP0Gs4/qnbeQySSjJMvicy/2x2+Z7ctgM4cpcy1
	mFVrWaKNXO/XT3nKO2x2N5tfF+qJNAg6xiwMGosvm/rhT+fXNtZl/iR8OvJq1g==
Date: Tue, 08 Oct 2024 19:32:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
In-Reply-To: <ZwVlE9bgHYNT8J7J@finisterre.sirena.org.uk>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
 <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
 <ZwVlE9bgHYNT8J7J@finisterre.sirena.org.uk>
Message-ID: <c4a72fcf91b30a8eae2fff851f01d10a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Mark,

On 2024-10-08 19:00, Mark Brown wrote:
> On Tue, Oct 08, 2024 at 06:18:46PM +0200, Dragan Simic wrote:
> 
>> I just spotted a couple of small typos, noted below, and I hope you 
>> won't
>> mind to apply the fixes by hand before applying this patch, please?
> 
> Sorry, your mail arrived after I'd already published the changes -
> please send an incremental patch for the one in the comments.

No worries.  I just sent the incremental patch, [1] please have a look.
Thanks for merging this patch series!

[1] 
https://lore.kernel.org/linux-spi/cec37f5568afaef8fca2d35bb01c90556ccbb4f4.1728408464.git.dsimic@manjaro.org/


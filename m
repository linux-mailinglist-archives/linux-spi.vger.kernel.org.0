Return-Path: <linux-spi+bounces-3201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38038D8815
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0DB1F226F5
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03EA12EBE9;
	Mon,  3 Jun 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wCwpL04X"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166E1366;
	Mon,  3 Jun 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436229; cv=none; b=B+a98InNCLNeX7Vczxz4QKYoIN54WsGQEcAYk5esgEoqhb5XlIHO1eBPFD8NE4+HnSkhvgGCIC0JkRWsUWoClD9m3veg/cuMZYxjU70QsVYOGw5/TbaKhAUPzXzhBBFw7RLscXvvfrB2Mi6HyLCb/tvQBM5F1q9MB7U06DhAF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436229; c=relaxed/simple;
	bh=ZW1DatwdmRH9cZ/B4K/8KuBW3OJWeP+G7l9i6th87d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSbTmJn4h+lIizloxNtcAM+t+TxFgjPfJyOofk0lCTenS+MnjGadfrOrJso0LlHcBcACq0LVLl1yr6dHcgznyfV3pJgTRXNL7J4XOeghFJLR/uybni/Yk/+93QuxiwP0o70ifuqx/Mhsj7NBb6eVG0QRCbsTdiyd2SQTRS3XpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wCwpL04X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717436226;
	bh=ZW1DatwdmRH9cZ/B4K/8KuBW3OJWeP+G7l9i6th87d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wCwpL04X/I9ceMURLK4cpP/NGOR1Y/mvirXFNTmLl4xP1FwHJ3h3RseqTgaOpn8SM
	 y0JZLpgzNfn2qhjS0HZmypbD3jsYMTQjb9DDsDcZJBi6gN5drToesOmr6zP43P/Ldw
	 RL69PJqB+D+p/td6E+cgX/yOR5quN24okAb3nGLMVTWwLnVOCRWErJH5D+Tr9IvC5N
	 4bcGm7iX+Aj7mZYCsGNdZ75qRA4kOwbz/3fJvafdy5tgkZrDwZ47N3hN7PaAyB+7dx
	 ZPeBLCDjud+wtqidLXCm0XQvv8OyfwutR9HrwAPZ5IPXD2u42xwPl1PLt6kUjxyA78
	 KYoLIUSuX7aLg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1BF3C3782109;
	Mon,  3 Jun 2024 17:37:04 +0000 (UTC)
Date: Mon, 3 Jun 2024 13:37:02 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <e5c5edcb-e07b-4400-86ca-4d9a7fe4fc0c@notapiano>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
 <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
 <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
 <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
 <c258a169-cdbc-4a92-bae6-46bd38df86fb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c258a169-cdbc-4a92-bae6-46bd38df86fb@sirena.org.uk>

On Mon, Jun 03, 2024 at 01:26:36PM +0100, Mark Brown wrote:
> On Sat, Jun 01, 2024 at 12:45:30AM +0300, Andy Shevchenko wrote:
> 
> > I have sent a new series where the last patch has a massive rework of
> > the cur_msg_mapped flag. Would be nice to see if it passes your tests.
> > The main idea there is to actually move to per transfer flag(s) from
> > per message one.
> 
> That feels like a sensible cleanup but also a bit much for a fix with
> all the driver updates...

The current state of linux-next works fine, so there's nothing to fix. That
series is really a cleanup series, since the fix merged wasn't the cleanest
solution possible. (I'll be testing it shortly and posting the feedback there)

Thanks,
Nícolas


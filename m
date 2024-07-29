Return-Path: <linux-spi+bounces-4069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E193FE6C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 21:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB4B1F23DF0
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D6186E25;
	Mon, 29 Jul 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J+Q12iyh"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27514A0B7;
	Mon, 29 Jul 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282020; cv=none; b=JyScTq7Plr54M8jaDh3SwxW2C87V/gL1K6/NpaVLJbG0H3GBOXdxu/wLuNPIen0PFtnJBqAmxNPw6vvX18zG68G6JjOG9U6+wY3rZjGfsO7s5hS56wk02ac0lLyEKY9cLHK20xQ2I6E8kHAv9VYALTCGFhQJeJ4TlEc9CQp4LPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282020; c=relaxed/simple;
	bh=kaAMFQc35zsWdTsHHo5+ATinSUDamxGImLIP3C8cWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdU4WZ4KR2foLkhn7koRAD9n4qou6VzHg1MJ1CBnr47lQoCvDFEqWmzYbccOM5TVcmU7qr2XD8rTkcPjDxPfoNP5l68VSPicCxSkPQiTf0yO6efnxFKS4/kCSjkLeX8MDE+CPrhvVMoZrdIyEpssDv8YKjtUv3MRhFjCbprAhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J+Q12iyh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722282017;
	bh=kaAMFQc35zsWdTsHHo5+ATinSUDamxGImLIP3C8cWFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+Q12iyh0P9X2ZfDu7fRRgp5PoIwVVh637TISz4u1T2ifHLh7c18jld+4ntnM20hH
	 nemHITmMKLXKwjzCE01n1G+z9ej+yJ/DQ+5eo/UgcCjdGUwybN0wZxSLpCpvjv/8FL
	 CDKimzywB3GQDip1K2RmEtnVGYSPZeaPI8+fapnYLoKnQ4NxJ7UWSjIVwrQaEsuDSh
	 eUgkfhCQslz7hmm53F4vyOy7vYRyUXrvb5kjF58g27EheEdxcnwiMaRr6ncWOaX2+4
	 4AKjqMTKKfHbFyM805wANsIsNXB8FK8Q7+EMC7a6BahFZ5b4zD4Aq+JDp1+oTbMrZH
	 ITTn7DaC8ymNQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D12CE37809CE;
	Mon, 29 Jul 2024 19:40:15 +0000 (UTC)
Date: Mon, 29 Jul 2024 15:40:14 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] spi: Assign dummy scatterlist to unidirectional transfers
Message-ID: <2e56fee0-2bbb-4b7d-b955-6990b227c706@notapiano>
References: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>
 <ZleYXoesgdAboMoF@surfacebook.localdomain>
 <CAMSo37X1GRUtuyHDL5GfQAqbH8EVjgAWR129D3uTF3CRPpLKPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMSo37X1GRUtuyHDL5GfQAqbH8EVjgAWR129D3uTF3CRPpLKPQ@mail.gmail.com>

On Tue, Jul 23, 2024 at 12:05:52AM +0800, Yongqin Liu wrote:
> On Thu, 30 May 2024 at 05:04, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > Wed, May 29, 2024 at 11:42:35AM -0400, Nícolas F. R. A. Prado kirjoitti:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> > > introduced a regression: unmapped data could now be passed to the DMA
> > > APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi:
> > > Don't mark message DMA mapped when no transfer in it is") and commit
> > > da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
> > > APIs") addressed the problem, but only partially. Unidirectional
> > > transactions will still result in null pointer dereference. To prevent
> > > that from happening, assign a dummy scatterlist when no data is mapped,
> > > so that the DMA API can be called and not result in a null pointer
> > > dereference.
> >
> > I feel that with this the da560097c056 ("spi: Check if transfer is mapped
> > before calling DMA sync APIs") can be reverted as unneeded. Nícolas, can
> > you check that? If it works, we better revert the unneeded checks.
> 
> FYI, just tested based on the Android Common Kernel android-mainline branch,
> with only the following two changes, the issue is not reported too:
>     9dedabe95b49 spi: Assign dummy scatterlist to unidirectional transfers
>     9f788ba457b4 spi: Don't mark message DMA mapped when no transfer in it is

Hi Yongqin,

Simply reverting commit da560097c056 ("spi: Check if transfer is mapped before
calling DMA sync APIs") caused issues on the sc7180-limozeen platform as I
mentioned in
https://lore.kernel.org/all/1ea41944-a107-4528-8e8d-559c06907e3f@notapiano/.

Instead of that, Andy landed this commit reworking the flag, which got rid of
that check anyway and provided a cleaner solution:
https://lore.kernel.org/all/20240531194723.1761567-9-andriy.shevchenko@linux.intel.com/

Thanks,
Nícolas


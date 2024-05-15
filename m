Return-Path: <linux-spi+bounces-2857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16578C6D82
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEDB1C21ED3
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A615B0EA;
	Wed, 15 May 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nhumtoFw"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B51581E2;
	Wed, 15 May 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807380; cv=none; b=M9nyFR2epr0078/8NWzh6RoNeNtWjBkmQuLuRXpMywYkP3RimGEgT4cC5m0NQLHm2gJAqtPiCd+Cn2iECBFZsjasDOeZ/Llf3UePtqcTBmztE604lx3TG5HX6eFe+Yz71i2FaPiGFSPnJKGip71i+PewiTKskvpLqdjeH19rwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807380; c=relaxed/simple;
	bh=IdqRQoHjX1qYn6l4EEsY4maz5cWL/Ny60snmWjpeE4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b//OtdPwnELG3CTbYMgmhZo2VKaPYpNbPK/IeCKDyIS++3aIHjdpL5KFbHsicXqRj+8FHEvQKNwCPgtw+MkoOvmZ3aO+vy04iBqIuFogbqnHLrSx7vd0E82FLGSa7KgJ4XyW/PnlRMAeh6yWbqfTRUbh5+EeFBH/hP4ItAvwH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nhumtoFw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715807377;
	bh=IdqRQoHjX1qYn6l4EEsY4maz5cWL/Ny60snmWjpeE4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhumtoFwpqXlbsA/deMuEpBD5OeyXW8p9tm+a7DagIg/DWP0ISqB3LlBoaVeZxpPk
	 KEYXt7eosnkKfsiCMqB7Tp70fE09IuaQyzMN0nWhBWLrxgXPgAHmPNAeH5etinZ9pT
	 lKvEt+bMXiUtTbeGSs77d0zYzsyfMR+HymifjOxtVEsrA8BoezHat61b7s2r2wR/9X
	 vprQiRp0ieli6JUJaT99I//O6RX3S/Jqih57g2nS8ULP7yNxwtov5DHGhWguhT692e
	 TxxkzChB2oZWfFBvQvQZKLD4QjVmqNetGS19ofk1kwkef4S1fXm2QElA+KsobHPu+u
	 TpU3pPGjkFOCg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1838B378218D;
	Wed, 15 May 2024 21:09:35 +0000 (UTC)
Date: Wed, 15 May 2024 17:09:33 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>

On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> have checks for orig_nents against 0. No need to duplicate this.
> All the same applies to other DMA mapping API calls.
> 
> Also note, there is no other user in the kernel that does this kind of
> checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

this commit caused a regression which I reported here:

https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano

along with some thoughts on the cause and a possible solution, though I'm not
familiar with this code base at all and would really appreciate any feedback you
may have.

Thanks,
Nícolas


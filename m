Return-Path: <linux-spi+bounces-8995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D988DAF5885
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 15:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CA0189133A
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A6285C87;
	Wed,  2 Jul 2025 13:19:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD52857DA;
	Wed,  2 Jul 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462369; cv=none; b=Enbus/O4SKoTt5+dk9mia0nXTUAsLaTTcUxka645Nc/DKC89zghRpWvOgN8fwPa9OLfPNHCgPT8VLWVn36kEVbS8P1lIUp+t47Nr6BTLZiox9biyz7enDoG9eFBL+06VK09ZLI+fNG82J6VRBZMdZc3g7M73ukWnJwpUQcSX1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462369; c=relaxed/simple;
	bh=w7XgPwloDUij0Z+gHy5bOJpLrITKLh+THakaSZhTow8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8G3iA/Att34Ag5nOGCyFbDMyaAQgLVy6r2oR65vvd37Aevsz6rkwi7a4b6vdY4pbXyqFvnpqPJPRcPGnr65vjXybBQLVud40vt7FnsRBYCcXok9mj1SOUqAjhtDwCKTCSRmfT63crmQKKiQcpyoLDWlgNznCnhvAAgeorZ2FMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1uWwab-00058K-00; Wed, 02 Jul 2025 14:29:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6ECD3C0B23; Wed,  2 Jul 2025 14:06:28 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:06:28 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] MIPS: vpe-mt: mark vpe_free() and vpe_stop() as
 static
Message-ID: <aGUgxCzTmcBHbdR5@alpha.franken.de>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB1670546C9A13C18720FECE1BBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB1670546C9A13C18720FECE1BBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>

On Wed, Jun 18, 2025 at 10:53:25PM +0800, Shiji Yang wrote:
> These functions are only used in the current source file "vpe-mt.c".
> Do not export them and mark them as static to silence the missing
> prototypes warnings:

you are breaking the whole idea of this interface, The functions are
exported for other kernel modules. By removing it you break them.

If we know that this interface is unsued, we should remove the
whole kernel module, but I don't know if it used somewhere.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


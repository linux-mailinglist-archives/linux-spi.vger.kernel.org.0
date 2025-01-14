Return-Path: <linux-spi+bounces-6351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA63A10391
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 11:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E7162932
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB81ADC85;
	Tue, 14 Jan 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rs/mdunU"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3881ADC83
	for <linux-spi@vger.kernel.org>; Tue, 14 Jan 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849014; cv=none; b=RxJafYFIc46vqRLjvTg3BnffozPSRLi1QjFKF0vSsqc8tN8STa1kjY5jbkpWSVkKJIQC0NmBZHszBCb9ZwdnFlL3uz869ygcimB+NM274IEIBWeYL1HJjBuVk9HcvLNfrjPox6X8v/o/waj1J7o3TmpoTzZcMMV+XDwlxl2H9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849014; c=relaxed/simple;
	bh=XxBl7fqbol2wF8Nze2ZnW9469ZvGsqPLH3XklpIMLVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQPf8Elv0RBvpqaCssPq/Qq8VRxREHftGMeOdf3QIQjJzayofDtJDNn6tNdEHhNaZZlKJ2FMYX/ruatO/+ImJUe1208eVoPKJbwflqBZe4pLobyRHS6Th1PfiUvgjS49wDxlJQUkjkEf5/9TE0fc8K7bmlY7OhMO5cZKkLDo1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rs/mdunU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A08241BF208;
	Tue, 14 Jan 2025 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736849004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZP+d0H4m0h7sGo8b5wNABwTCHdXtZyl2DG9g0bftT0=;
	b=Rs/mdunUKsfz0B3EOWPoFv8ZvGeGvqE6sSFNxtiw+SqUJdkHeFRhbsFkBx6rcBd36R/wVB
	VJILrx+XzxVNrrwb9uPPRIBM4POEsgsZ/DdhAXUKchNYvAZQsfO8a/Jo/5zuGdGbjIi90m
	mgEtqd+j+HHkUQ9QQl6pg7AtjBw0Z3tESBlGeR5RH0UPaLwBiW+6pnySRT6hWu+iIQ9uAC
	rV7q/7sPWY7aUunidaMAZ8GkJStpVq3SWbjlIpKAkOmxqjkFjzBV4qTzi5YKjuNRFO4C9H
	6qAfLa52XWbCsfKL71ULMA7T2asERC8mrjkWvY+OqWc2HUJ5DrkP28KLoG7UwQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,  Nathan Chancellor
 <nathan@kernel.org>,  linux-spi@vger.kernel.org,  llvm@lists.linux.dev,
  patches@lists.linux.dev,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
In-Reply-To: <173678670956.71125.2320310623665812760.b4-ty@kernel.org> (Mark
	Brown's message of "Mon, 13 Jan 2025 16:45:09 +0000")
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
	<173678670956.71125.2320310623665812760.b4-ty@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 14 Jan 2025 11:03:22 +0100
Message-ID: <87h661u2z9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

On 13/01/2025 at 16:45:09 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Sat, 11 Jan 2025 12:08:38 -0700, Nathan Chancellor wrote:
>> After commit e6204f39fe3a ("spi: amd: Drop redundant check"), clang warn=
s (or
>> errors with CONFIG_WERROR=3Dy):
>>=20
>>   drivers/spi/spi-amd.c:695:9: error: variable 'ret' is uninitialized wh=
en used here [-Werror,-Wuninitialized]
>>     695 |         return ret;
>>         |                ^~~
>>   drivers/spi/spi-amd.c:673:9: note: initialize the variable 'ret' to si=
lence this warning
>>     673 |         int ret;
>>         |                ^
>>         |                 =3D 0
>>   1 error generated.
>>=20
>> [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!

I'm wondering whether it's relevant to pull the branch you shared
as-is. Do you plan on pushing this patch of top of it? Or shall I wait
-rc1 for the SPI NAND part?

Thanks,
Miqu=C3=A8l


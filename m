Return-Path: <linux-spi+bounces-8076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4BAB33CE
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 11:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3553AA51E
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAD1AB52D;
	Mon, 12 May 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbajbUW7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225F7DA93;
	Mon, 12 May 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042489; cv=none; b=YdN9pqtsYTmtxdtuq3ELAy6u9v7Gt1GzwiAvGMLwHthJ9weU25CTMacKANuVex5tSbmV/T7AbolupJYrMoeL2XD1HYqIyPtET6xsj+gS/rWZIzrD4vqm3Gva3g2qneZTJTncwY1wRPVErGmU/LjCoWmF/wA6nv463S1KXc5ZXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042489; c=relaxed/simple;
	bh=w58paniyZtCqV2wtIcE3EAeN7LrUtsoNYt39HAUVduQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9U5PMGcl6oDMUB6lZk8YMK+hCKv/pMoOA9buZ7tKWB7vdpT5qqEU+6/huPgBwkubPbK7K+u0VWnghtn8tLb43ugR08LOK86SSG6DtGbcEnxSrH3SeKlsflo13uHxK6B6kDsOgOyBhUsF+ZW2+R6EpCqJv44jEdt/r4Stv/LiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbajbUW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A031C4CEE7;
	Mon, 12 May 2025 09:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042488;
	bh=w58paniyZtCqV2wtIcE3EAeN7LrUtsoNYt39HAUVduQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tbajbUW78IyTN4z0SlV8ai34Qau8HaPSBbmS72QqKwBh8hUezo7G0aiz07N83Mmq3
	 MXpJTfpBVPaMW6yMhzcBbUIcAvTMGFdWZChj0jH7oyD0Q/y5oQiC3EwDabSCBq7cQu
	 GuhSWQN4Vlsr7/Id1NTFVA2/v3VzDQ5+0ORf4dEKE7sIVDArUGyiVElmpQcqpntRDi
	 QOLDmtggOsIzzTyxfIICI97sfJGM6SWQX/2cx1ONC7y99fV+uRjtcXCkb91ALd8G9y
	 BQLbKOFBFRNDtsh+r1iW/uGLQfOKYaRA6yFXYxFAriMfoPX+Ylvs6KUc1kSAUbA4Kj
	 b9Evr3OudGl6g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Luke Wang <ziniu.wang_1@nxp.com>,
  "broonie@kernel.org" <broonie@kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "michael@walle.cc" <michael@walle.cc>,  "p.yadav@ti.com"
 <p.yadav@ti.com>,  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com"
 <vigneshr@ti.com>,  Bough Chen <haibo.chen@nxp.com>,  Han Xu
 <han.xu@nxp.com>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <87cycep8go.fsf@bootlin.com>
References: <DU2PR04MB85678048FE8B475B1E323E0AED802@DU2PR04MB8567.eurprd04.prod.outlook.com>
	<10b40148-b949-442d-9d43-0db09517269a@linaro.org>
	<mafs0zffo3gea.fsf@kernel.org> <87cycep8go.fsf@bootlin.com>
Date: Mon, 12 May 2025 09:34:45 +0000
Message-ID: <mafs0wmam6ukq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 12 2025, Miquel Raynal wrote:

> Hello,
>
> On 07/05/2025 at 09:43:25 GMT, Pratyush Yadav <pratyush@kernel.org> wrote:
>
>> Hi Luke,
>>
>> On Tue, Apr 29 2025, Tudor Ambarus wrote:
>>
>>> On 4/29/25 10:03 AM, Luke Wang wrote:
>>>> Hi Pratyush,
>>>> 
>>>> I'm following up on this patch series [1] Avoid odd length/address read/
>>>> writes in 8D-8D-8D mode. While some of the series has been merged, the
>>>> patch 4-6 remains unmerged.
>>>> 
>>>> In fact, we also encountered similar read/write issue of odd address/
>>>> length with NXP FSPI controller (spi-nxp-fspi.c). Currently, we handled
>>>> the odd address/length in the controller driver, but I think this should
>>>> be a common issue in the octal dtr mode. Was there a technical reason
>>>> for not merging the core layer solution?
>>>
>>> I guess I stumbled on those small comments and did not consider the
>>> greater benefit of taking the patches. No one cared and we forgot about
>>> it. Please address the comments and resubmit.
>>
>> Yes, it should have been a simple next revision from me but apparently
>> it fell through the cracks. I do strongly agree that this should be done
>> in SPI NOR, and not in controller drivers. So it would be great if you
>> can respin the remaining patches of the series.
>
> The fact is that we will have octal DTR support in SPI NAND as well at some
> point, hence a common solution would be welcome as we will likely face
> similar problems when performing these unaligned accesses. I don't know
> how feasible it is yet, but if we have a fix for SPI NOR, we will need
> something similar for SPI NAND.

The common solution would then probably be in SPI MEM? Since you need to
make sure you don't do an out of bounds read, you need to know the size
of the flash at least. That is recorded in the dirmap operations, so
perhaps we can have this logic in spi_mem_dirmap_{read,write}()? Haven't
thought too deeply so not sure if it would end up being a good idea.

-- 
Regards,
Pratyush Yadav


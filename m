Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2405D1CE04
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfENRbX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 13:31:23 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16862 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRbX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 13:31:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdafb420000>; Tue, 14 May 2019 10:30:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 May 2019 10:31:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 May 2019 10:31:22 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 17:31:19 +0000
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ec2e9dab-e299-0f73-090c-e060b4683361@nvidia.com>
Date:   Tue, 14 May 2019 18:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557855042; bh=YMzIdisAdXm/iBe7klK+iK4HBjCqpEJXQXlJFqH8UK4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gQ4mmKhZyNlgdguwb9bbNJsU0Szqa8kxB0u4uuv+dG/N8ZNCl2sNpGr5lFDGjEb9u
         VjIeol9dtPEbd2ThkKPE360AMOq7VF4yIGU7PvqEplkl56uxlmI1vynbDyqF76kjlV
         KqN8ihk2h8L/RgSmn6aduGrzKzd9YGpgqlPtU3Oz9Pmhizij1RVUg/STUnPWXUvO+b
         WS7nCDJ1/D4G1k5dyccxHTuWaJwShr5GsZWka3/brIimwaVEMKsCJHRl52ZWHCHGwq
         zyVzlo3nv8MFzggasbtFaFxUZa8xkZqihYHa4bbErXgPgXdwl1TYhiuS1RAzss6+W8
         rsvGGyykdvV6Q==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 14/05/2019 18:18, Sowjanya Komatineni wrote:
>> Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
>=20
>> On 14/05/2019 06:03, Sowjanya Komatineni wrote:
>>> This patch adds support for GPIO based CS control through SPI core=20
>>> function spi_set_cs.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> Can you elaborate on the use-case where this is needed? I am curious wha=
t platforms are using this and why they would not use the dedicated CS sign=
als.
>>
>> Cheers
>> Jon
>=20
> Tegra SPI doesn=E2=80=99t support inter byte delay directly to meet some =
SPI slave requirements.
> So we use GPIO control CS in parallel with a dummy HW CS and use inactive=
 cycles delay of SPI controller to mimic inter byte delay.
>=20
> Currently we don=E2=80=99t have specific SPI slave on upstream supported =
platforms but considering raspberry PI header where SPI I/F is exposed to p=
ins it allows user to connect any SPI slave and this helps for some slaves =
that need specific inter byte delay.

Maybe add these details to the commit message so that it is clear what
the motivation for this is.

Thanks
Jon

--=20
nvpublic

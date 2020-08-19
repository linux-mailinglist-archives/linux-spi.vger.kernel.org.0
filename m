Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5023A249FBC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHSN0C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:26:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55597 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHSNZn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:25:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819132540euoutp02752cf7bc7b07638004f90ab6963436ba~srjwO-Cku1715017150euoutp02o;
        Wed, 19 Aug 2020 13:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819132540euoutp02752cf7bc7b07638004f90ab6963436ba~srjwO-Cku1715017150euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597843540;
        bh=6tQ7r9/JkINLNVxiBMcZz+jcczP33Mvp9fg6Z1MmgAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTH+T/tyBuBmMyMMxltTcyYqMVTVRTQOr3SsZplN7TWGgcNckjsZral+WA+qAiNAv
         yhAm63wrZ/SmKvktlI7QmMwQfixfCLB/UcrxBdtefxY774AFUCx454oI1fxgvgPsoL
         JkbHmzJCDWZjdPl7YzVv6rtoM1rhls48GHsX4EVs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819132540eucas1p2440d360295d145b7c150bd8ff1fd0971~srjwBcmF51632416324eucas1p2U;
        Wed, 19 Aug 2020 13:25:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.EC.06318.4582D3F5; Wed, 19
        Aug 2020 14:25:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819132540eucas1p1897948a4f4008ab4946120dd4fa5c192~srjvomnA61524415244eucas1p1-;
        Wed, 19 Aug 2020 13:25:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819132540eusmtrp17afec651cfd46becb0badc1b75068aec~srjvn5lWl1886018860eusmtrp1_;
        Wed, 19 Aug 2020 13:25:40 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-20-5f3d2854de07
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.EB.06017.4582D3F5; Wed, 19
        Aug 2020 14:25:40 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819132539eusmtip168e62beb0b0436f8b38785ab10e25e99~srjvchHgF3073530735eusmtip1B;
        Wed, 19 Aug 2020 13:25:39 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 5/8] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Date:   Wed, 19 Aug 2020 15:25:26 +0200
In-Reply-To: <20200819123732.GA18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:37:32 +0200")
Message-ID: <dleftjlfia22ex.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87ohGrbxBr2HZC0W/3jOZLFxxnpW
        i6kPn7BZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWjR9vslusPXKX3YHL4/qST8wem1Z1
        snlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBm7735gLVguWrFx7Uf2BsZHgl2MnBwS
        AiYSN5+cZe5i5OIQEljBKLFizV4o5wujxJ2DR1khnM+MEmee/2WHaZk67S8jRGI5o8Skt3+h
        Wp4zStzYeATI4eBgE9CTWLs2AqRBREBT4vrf72CTmAWWM0ksvd3ICJIQFoiXePX0C5jNIqAq
        0XrvIRuIzSlQJjHh5VOwbbwC5hIHD31jAbFFBSwltry4DxUXlDg58wlYnFkgV2Lm+TdgF0kI
        3GOX6Nh2hBHiVBeJ352dULawxKvjW6BekJE4PbmHBeRQCYF6icmTzCB6exglts35wQJRYy1x
        59wvNgjbUeLTtnesEPV8EjfeCkLs5ZOYtG06M0SYV6KjTQiiWkViXf8eqClSEr2vVkBd4CGx
        4HUfGySsmhglPqy9wj6BUWEWkndmIXlnFtBYZmDYrd+lDxHWlli28DUzhG0rsW7de5YFjKyr
        GMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPX6X/Hv+5g3Pcn6RCjAAejEg9vgJJtvBBr
        YllxZe4hRhWgSY82rL7AKMWSl5+XqiTC63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNF
        L2OFBNITS1KzU1MLUotgskwcnFINjN2Tu865Sbo5P+tfde6F5pxfBz9877yxyYahrnvqpx/r
        v/1acUCuIIt1kVJR9PID5+dpBZ5VrG32Dd4R49b6Wmmd9IXczrmzegxkCgPnti/4fv/+Hes9
        H7lzDLye35i05Z9IsebU3S/WNS7cPuWYpWjK1ywr1WvV6XsmfH/wZ4+sw7OvDLrLbpxRYinO
        SDTUYi4qTgQApxElDmUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7ohGrbxBrNvMlss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+QuuwOXx/Uln5g9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJ23/3AWrBctGLj2o/sDYyPBLsYOTkkBEwkpk77y9jFyMUhJLCUUeLN
        rpUsXYwcQAkpiZVz0yFqhCX+XOtig6h5yihx9PQtVpAaNgE9ibVrI0BqRAQ0Ja7//c4KYjML
        zGeS+P3LA8QWFoiVeLdjLjNIuRBQ+ezZ7CBhFgFVidZ7D9lAbE6BMokvZ5eBtfIKmEscPPSN
        BcQWFbCU2PLiPjtEXFDi5MwnLBDjsyW+rn7OPIFRYBaS1CwkqVlA25iBLlq/Sx8irC2xbOFr
        ZgjbVmLduvcsCxhZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG3LZjP7fsYOx6F3yIUYCD
        UYmHN0DJNl6INbGsuDL3EKMK0JhHG1ZfYJRiycvPS1US4XU6ezpOiDclsbIqtSg/vqg0J7X4
        EKMp0J8TmaVEk/OBSSKvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwen
        VAMju2Wv91Sefc1Jl9U/v9IPy8nYl7om52FJTZZc4/Jbh+vn1Nxw+336j+WOI92ZYrWLtioH
        BQu/t9rTMZ3n6e4fKxo3cS+e+6d64cw0ttU+Z11WGgg81jjMnFWnUaIUNEuVo6lh/xzPp+ym
        Ld/Ckp2iD65Jf7zqiaPYLT5PE+uFzkLzdiy1aluuxFKckWioxVxUnAgAtulwxNoCAAA=
X-CMS-MailID: 20200819132540eucas1p1897948a4f4008ab4946120dd4fa5c192
X-Msg-Generator: CA
X-RootMTR: 20200819132540eucas1p1897948a4f4008ab4946120dd4fa5c192
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819132540eucas1p1897948a4f4008ab4946120dd4fa5c192
References: <20200819123732.GA18122@kozik-lap>
        <CGME20200819132540eucas1p1897948a4f4008ab4946120dd4fa5c192@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:37>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:05PM +0200, =C5=81ukasz Stelmach wrote:
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>
> Hi,
>
> Missing commit msg - fix what exactly?
>
> You need to rebase your patch as most of these were already fixed by Lee
> Jones.
>
> However he did not remove the @rx_dmach and tx entries...

I will.

>> ---
>>  drivers/spi/spi-s3c64xx.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6fe896f2be18..505789f91fdf 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -155,19 +155,21 @@ struct s3c64xx_spi_port_config {
>>   * @clk: Pointer to the spi clock.
>>   * @src_clk: Pointer to the clock used to generate SPI signals.
>>   * @ioclk: Pointer to the i/o clock between master and slave
>> + * @pdev: Pointer to the SPI controller platform device
>>   * @master: Pointer to the SPI Protocol master.
>>   * @cntrlr_info: Platform specific data for the controller this driver =
manages.
>>   * @lock: Controller specific lock.
>>   * @state: Set of FLAGS to indicate status.
>> - * @rx_dmach: Controller's DMA channel for Rx.
>> - * @tx_dmach: Controller's DMA channel for Tx.
>> + * @rx_dma: Controller's DMA channel for Rx.
>> + * @tx_dma: Controller's DMA channel for Tx.
>>   * @sfr_start: BUS address of SPI controller regs.
>>   * @regs: Pointer to ioremap'ed controller registers.
>> - * @irq: interrupt
>>   * @xfer_completion: To indicate completion of xfer task.
>>   * @cur_mode: Stores the active configuration of the controller.
>>   * @cur_bpw: Stores the active bits per word settings.
>>   * @cur_speed: Stores the active xfer clock speed.
>> + * @port_conf: Pointer to the SPI port configuration
>> + * @port_id: SPI port ID number
>>   */
>
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89KEYACgkQsK4enJil
gBCMYAf/WVzyjutSHX4y+lBqAPOCf3w6v28WJExKEK4DB0CjgMjPm4zkANXSFHCj
BXXT3V+Px64aJrHpOuzkjm36dTbGPaR6rDplKTvTuqH/EOMvA2JCs4Xy7bx24j/i
BQUHjDU34UVKvSkalOH3g1o9IGzMfqUNfTwstsvGinxKjFLgapCG+jZtKR48qVw9
xszonutcmWbCTPCOOJbc7zp2d0CttobJWln+DfjB5C9PcRpFIrAWDnT8AD88btze
PKlRohh79xJHHxjZlZZ2ArdZuZNZSMvLeW7IznPj02C/n6GGZ3DT5RfVd9HzpdPy
bY4cIZjqmDMw+mv42kv9AdZnJy6GNQ==
=WUY2
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C1CE761
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 23:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgEKVZL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 17:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgEKVZK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 17:25:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972EF2070B;
        Mon, 11 May 2020 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589232309;
        bh=CtO5mYJkEMCa+g10iw5cPJ5O+4m8v/bmewkN5XaZdDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxij7xW9DTj9s50jGIvX39/1QsaHw8HVOf7tG6JqjU7XC+R8gn39Kq47plzmh9DDN
         RuM5p0X5kDR7u7icdeJ6pBrPAuYKtBuhRFNHWuyYdZy93DzkpPpq0uKGa4lcCScYSE
         ilcIzqbuShcP4h5XIal9Ug81phCbRZT6haLi177I=
Date:   Mon, 11 May 2020 22:25:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200511212506.GA23852@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200510002039.hwahqasnnceowskz@mobilestation>
X-Cookie: APL hackers do it in the quad.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2020 at 03:20:39AM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 12:37:51PM +0100, Mark Brown wrote:

> > Your CC list on this series is *very* wide - are you sure that this is
> > relevant to everyone you're sending things to?  Kernel developers often
> > get a lot of mail meaning that extra mail can become a bit overwhelming
> > and cause things to get lost in the noise.

> MIPS folks are here since Baikal-T1 is a MIPS-based chip and this patchset
> is a part of the campaign of integrating the SoC support into the kernel.
> With Lee and Miquel we discussed the dirmap support in the framework of a=
nother
> patchset. Rob and devicetree-list are CC'ed due to having the bindings tr=
ee
> updated. Then a series of folks who recently submitted the biggest update=
s into
> the spi subsystems so might have valuable comments for this driver as wel=
l. So
> yes, I am sure.

I think you've got too many people who've been contributing to the
subsystem here at least - it looks like you picked up some people who
recently wrote drivers but haven't been doing a lot of review for
example for example.

> Anyway ok. I'll fix it. Is it ok to have the C-style comments in the head=
er
> file?
> * It isn't included by any assembly so from this point of view C++ style
> * shall also work there.

The SPDX stuff requires C style comments in headers so yes.

> Secondly the message of that commit states "Devices with chip selects dri=
ven
> via GPIO are not compatible with the spi-mem operations." I find this sta=
tement
> questionable, because for instance this device supports memory operations=
 with
> GPIO-driven CS. Though in current implementation the driver fallback to u=
sing normal
> push-pull IO mode if GPIO CS is utilized as safer one. But even in this c=
ase
> it's better than splitting the memory operations up into the transfers, w=
hich is
> developed in the spi_mem_exec_op() method.

> So in this matter my question is: how to modify the SPI-mem interface so =
the
> SPI-memory operations would also work with GPIO driven CS? Some additiona=
l flag
> might work...

Yes, some flags should work here - the issue was that at least some
controllers may end up trying to do multiple SPI operations for one
spi-mem thing which will break if the chip select doesn't get changed to
correspond with what's going on.

> Thirdly what about dirmap operations? If we got a GPIO driven CS then due=
 to
> lacking any CS manipulation in spi_mem_dirmap_read() method we wouldn't h=
ave
> been able to make the direct mapping working without manual setting the G=
PIO.
> So the same question here. How to work this around and justify your requi=
rement?
> Until the question is answered and we come up with reasonable solution in=
 order
> to have the SPI-mem/dirmap interface working together with GPIO CS suppor=
t I have
> to leave the manual GPIO manipulation.

If the issue with ensuring that chip select is managed appropriately for
transfers can be resolved then push that stuff up to the framework.  If
not then it's not clear that the open coded version can work well
with GPIO chip selects either.

> > > +static void bs_update_cfg(struct bt1_spi *bs, struct spi_transfer *x=
fer)
> > > +{

> > This has exactly one caller, perhaps it could just be inlined there?  I
> > think this applies to some of the other internal functions.

> I don't want to inline methods just because they are used in a single pla=
ce. This
> might worsen readability and in this case it will. Currently the transfer=
_one()
> method is consistent with self-explanatory methods: update config, push-p=
ull
> bytes/words, check status. This also applies to the rest of the code. I c=
an
> consider some improvements/optimizations in this matter though, but embed=
ding
> the functions isn't one of them. Moreover the compiler does the static
> methods inlining automatically as soon as it sees they are called just on=
ce.

One of the things that creating internal APIs like this does is that it
adds another layer of structure to the driver, making it a bit harder to
follow that it's following the usual structures of a Linux driver
(especially noticable here given the open coding).  It creates the
impression of the platform portability layers that people sometimes try
to build.

> > > +static int bs_check_status(struct bt1_spi *bs)
> > > +{

> > It's not obvious from the name that this function will busy wait rather
> > than just reading some status registers.

> What do you suggest then? Renaming? Splitting up? If renaming, then what =
name do
> you prefer? Something like bs_check_completion()?

wait_for_completion() or something else that mentions that it will wait
for completion rather than just looking to see if the operation has
completed.

> > > +static int bs_exec_mem_op(struct spi_mem *mem,
> > > +			  const struct spi_mem_op *op)
> > > +{

> > It's not clear to me that this hardware actually supports spi_mem in
> > hardware?

> SPI-mem operations are implemented by means of the EEPROM-read and Tx-only
> modes of the controller.

Sure, but those seem like normal SPI-level things rather than cases
where the hardware understands that it has a flash attached and is doing
flash specific things.  A very common case for this stuff is that
controllers have acceleration blocks for read and fall back on normal
SPI for writes and erases, that sounds like what's going on here.

> > > +	if (!bs->cfg.cs_gpiod) {
> > > +		bs_push_bytes(bs, cmd, len);
> > > +
> > > +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> > > +			ret =3D bs_pull_bytes(bs, op->data.buf.in,
> > > +					    op->data.nbytes);
> > > +	} else {
> > > +		bs_pp_bytes(bs, cmd, NULL, len);
> > > +
> > > +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> > > +			bs_pp_bytes(bs, NULL, op->data.buf.in,
> > > +				    op->data.nbytes);
> > > +	}
> >=20

> > The actual transfers here are done using the same PIO functions as
> > everything else as far as I can see which makes me wonder what this
> > spi_mem implementation is adding over the standard SPI flash support.

> No, if no GPIO CS is supplied the memory read operation is performed by m=
eans of
> the EEPROM-read mode of the DW SSI controller (Write command is written t=
o the
> Tx FIFO and read data length - to the CTRLR1 register). The memory write

So EEPROM read mode is a combined write/read - is that somehow less
performant or something than separate opeations so there's a reason not
to use it except in this special circumstance?

> operation utilizes the Tx-only mode (just push data to the Tx FIFO, contr=
oller
> discards all incoming data). See bs_set_cfg() for details.

That's not super illuminating on this issue?

> If GPIO CS is utilized then we fallback to the normal push-pull methods b=
ecause
> first it's safer this way, second it's still better than handling multipl=
e SPI
> transfers.

> BTW The EEPROM/Tx-only modes are required to be utilized for the controll=
er on
> our SoC in order to support the SPI bus operations with highest frequenci=
es.
> Due to relatively slow APB bus performance we have to minimize MMIO opera=
tion
> per a single byte read/write. This is another reason why we had to create=
 a
> dedicated driver for this controller.

If the controller has support for TX only mode that seems like a good
thing to have in the generic driver - for TX only transfers that's less
bus I/O.  The EEPROM mode potentially also, I'm less clear on what
exactly it is but it sounds potentially useful for common cases with
register operations.  Perhaps other systems might have similarly slow
buses and get noticable performance benefits from using these modes.

> > > +static void bs_copy_from_map(void *to, void __iomem *from, size_t le=
n)
> > > +{
> > > +	size_t shift, chunk;
> > > +	u32 data;

> > This feels like something that is likely to be suitable for a generic
> > implementation?  Indeed I'd kind of expect that the architecture
> > memcpy_to/fromio() would try to copy aligned blocks since it's usually
> > going to perform better (which I assume is why this function is doing
> > it).

> MIPS memcpy_to/fromio don't do this. They expect the MMIO space can be re=
ad in
> a same way as normal memory space. It's our controller "feature", that MM=
IO can
> be only accessible by lw/sw instructions. So I had no choice but to imple=
ment the
> aligned read/write operations by myself here. AFAICS this won't be suitab=
le for
> the generic implementation due to the alignment restriction and the contr=
oller
> setups, which are supposed to be performed before accessing the dirmap MM=
IO.

You should document this in the driver so nobody comes along and does
the refactoring as a cleanup, it looks like duplicated or redundant code.

> > This seems a bit much - we can validate that the message doesn't contain
> > any delays (which is going to be the overwhelming majority of devices)
> > or multiple transfers and reject just those transfers we can't support.
> > Multiple transfers are an issue with this hardware but you could
> > implement support in the core for coalescing them into single transfers,
> > this isn't the only hardware with automatic chip select handling that
> > can't cope with scatter/gather so it would be a useful thing to have.

> As I said in the commit message to the binding this controller is nearly =
always
> connected to an external SPI flash (I'd say always, because Baikal-T1 is =
fully
> functional only when initially booted from an SPI flash). At least I don'=
t know
> any hardware using this interface differently (I've worked with all devic=
es with
> Baikal-T1 SoC on board). In current driver implementation the SPI-mem ope=
rations
> covers the native CS case while the prepare_message()/transfer_one()/unpr=
epare_message()
> are used when GPIO-driven CS is available (due to the commit 05766050d5bd=
 I had
> to implement it). So I didn't want to over-complicate the driver just to =
support
> some virtual hardware before it's really necessary.

Aside from the issue of tempting fate in board designs this circles back
to the open coding of the bits of the spi-mem stuff that aren't really
offloaded by the hardware - the driver would look a lot more standard
(and be closer to spi-dw I guess) if it only implemented the bits that
are offloaded and this interface was available.  Having the normal
SPI message interface would not only support non-flash hardware, it'd
also enable the use of more of the generic SPI flash code like other
similar controllers.

> > > +static int bs_transfer_one(struct spi_controller *ctrl, struct spi_d=
evice *spi,
> > > +			   struct spi_transfer *xfer)
> > > +{
> > > +	struct bt1_spi *bs =3D spi_controller_get_devdata(ctrl);
> > > +
> > > +	bs_update_cfg(bs, xfer);
> > > +
> > > +	if (bs->cfg.dfs <=3D 8)
> > > +		bs_pp_bytes(bs, xfer->tx_buf, xfer->rx_buf, xfer->len);
> > > +	else
> > > +		bs_pp_words(bs, xfer->tx_buf, xfer->rx_buf, xfer->len / 2);
> >=20
> > This will have issues with transfers with an odd number of bytes won't
> > it?

> No, it won't. Transfers with bits per word greater than 8 should have even
> number of bytes seeing the len field is supposed to have the buffers leng=
th in
> bytes:

So dfs is bits per word?  This is one of those things where the internal
APIs make things harder to follow.

> > Perhaps consider regmap_mmio?

> For multiple reasons no. First of all I need a direct access to the DR re=
gister
> and I need to do this as fast as possible due to relatively slow APB
> bus. The same concern is regarding the controller configs setting. Second=
ly
> everywhere in the driver I use the normal read/write methods and there is=
 no
> need in even a basic regmap-update function. So an additional abstraction=
 like
> regmap would be unnecessary complication. Thirdly the access to the regis=
ters

That comment was more due to writing debug infrastructure than stuff
like update_bits - the main reason regmap-mmio exists is for the debug
and cache features.  If the performance is too marginal to allow any
overhead then fine.  There's nothing stopping you combining regmap and
non-regmap on the same device if you exclude the more sensitive
registers from regmap with the access operations but it's not exactly
nice.

> > > +	if (!ret) {
> > > +		mutex_lock(&bs->ctrl->io_mutex);

> > Holding a mutex over the entire time that a file is open is not good,
> > it's also not clear to me what this mutex is supposed to be protecting
> > given that it's only referenced in these debugfs functions.

> Hm, it's io_mutex protecting the SPI IO operation to be thread-safe. See:
> spi_mem_access_start()/spi_mem_access_end();
> __spi_pump_messages();

> By locking the mutex here I make sure the DebugFS registers dump operatio=
n won't
> interfere the IO operations like dirmap, which make the registers unavail=
able
> for normal MMIO-based access.

Oh, it's the SPI level mutex...  that is a bit icky, and it does let
userspace code block the bus fairly easily which could be problematic
but I guess it's debugfs so meh.

> > > +		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);

> > Whatever this write is doing we never seem to undo it?

> Here I switch on the DW APB SSI registers to be available for normal
> readl/writel accesses. It's not a problem to leave the mode on, since
> bs_set_cfg() will do a proper config anyway.

A comment would help here, the fact that it's not undone looks like a
bug.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65wrEACgkQJNaLcl1U
h9AjIwf9Fy+l7bvyXx1oKzIOSkITTCZQx8wt8FBtBC0Y4+LE0cM8M/0dkk/iqPlW
heOaXIyDAU7bPVMRKyJDa1mIcsCBQGUB/L1gQHGhVl8FMx6SSsgELBMTgupL/giJ
Q/hjgTFisCoVn9XU9Gd3CfmLm7kmYVTYq4FrLepaVbXQsk9xNm9ZoD8bVNE+iKYL
QF52dlvU4iFjS0veSDP2ZKjIUnzLW5JKwxoP3xKkbrXlUnaLIVTMFLXd5tEDLuba
ftmZpSP2gXRVWBB0qk+pr89y3N75/B5UPFgxf/ky0BoCmtuXCMRQuhtxkLMPEfam
zgu8IPi+mgES2QEw6+yFjCaxw5DD8g==
=bOr3
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

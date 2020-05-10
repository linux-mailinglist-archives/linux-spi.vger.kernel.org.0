Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3A1CC5BA
	for <lists+linux-spi@lfdr.de>; Sun, 10 May 2020 02:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgEJAU5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 May 2020 20:20:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45404 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgEJAU5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 May 2020 20:20:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 240F68030875;
        Sun, 10 May 2020 00:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7DxagPb0Fvtz; Sun, 10 May 2020 03:20:41 +0300 (MSK)
Date:   Sun, 10 May 2020 03:20:39 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, John Garry <john.garry@huawei.com>,
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
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200510002039.hwahqasnnceowskz@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508113751.GD4820@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 12:37:51PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 12:36:21PM +0300, Serge Semin wrote:
> 
> Your CC list on this series is *very* wide - are you sure that this is
> relevant to everyone you're sending things to?  Kernel developers often
> get a lot of mail meaning that extra mail can become a bit overwhelming
> and cause things to get lost in the noise.

MIPS folks are here since Baikal-T1 is a MIPS-based chip and this patchset
is a part of the campaign of integrating the SoC support into the kernel.
With Lee and Miquel we discussed the dirmap support in the framework of another
patchset. Rob and devicetree-list are CC'ed due to having the bindings tree
updated. Then a series of folks who recently submitted the biggest updates into
the spi subsystems so might have valuable comments for this driver as well. So
yes, I am sure.

> 
> > This SPI-controller is a part of the Baikal-T1 System Controller and
> > is based on the DW APB SSI IP-core, but with very limited resources:
> > no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
> > FIFO available. In order to provide a transparent initial boot code
> > execution this controller is also utilized by an vendor-specific block,
> > which provides an CS0 SPI flash direct mapping interface. Since both
> > direct mapping and SPI controller normal utilization are mutual exclusive
> > only a one of these interfaces can be used to access an external SPI
> > slave device. Taking into account the peculiarities of the controller
> > registers and physically mapped SPI flash access, very limited resources
> > and seeing the normal usecase of the controller is to access an external
> > SPI-nor flash, we decided to create a dedicated SPI driver for it.
> 
> My overall impression reading this is that there could be a lot more
> reliance on both generic functionality and as Andy suggested the spi-dw
> driver - the headers seem easy for example.  As far as I can tell the
> main things this is adding compared to spi-dw are the dirmap code and
> the IRQ disabling around the PIO on the FIFO both of which seem like
> relatively small additions which it should be possible to accomodate
> within spi-dw.  For example the driver could have multiple transfer
> functions and pick a different one with the interrupt disabling when
> running on this hardware.

dirmap and IRQs disabling isn't all they have different. Please see my answer to
you in the cover-letter thread and the comments below in this email.

> 
> > --- /dev/null
> > +++ b/drivers/spi/spi-bt1-sys.c
> > @@ -0,0 +1,873 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> 
> Please make the entire comment a C++ one so things look a bit cleaner
> and more intentional.

This has been unexpected. It's first time I see such a requirement.
Anyway ok. I'll fix it. Is it ok to have the C-style comments in the header
file?
* It isn't included by any assembly so from this point of view C++ style
* shall also work there.

> 
> > +	writel(BIT(req->cs), bs->regs + BC_SPI_SER);
> > +	if (req->cs_gpiod) {
> > +		gpiod_set_value_cansleep(req->cs_gpiod,
> > +					 !!(bs->cfg.mode & SPI_CS_HIGH));
> 
> If you have a GPIO chip select you should just let the core manage it
> through cs_gpiod rather than open coding.

Of course I know this, and normally I would have omitted the GPIO manual
assertion (hopefully soon my hands get to merging the AX99100 driver I've
developed some time ago). The thing is that this Baikal-T1 System SSI device
driver has been initially written before commit 05766050d5bd ("spi: spi-mem:
fallback to using transfers when CS gpios are used"). So asserting GPIO CS had
been required to initiate the SPI memory communications seeing the generic
spi_mem_exec_op() doesn't do this. Manual GPIO manipulation is indeed redundant
for the current SPI-mem op execution procedure.

Secondly the message of that commit states "Devices with chip selects driven
via GPIO are not compatible with the spi-mem operations." I find this statement
questionable, because for instance this device supports memory operations with
GPIO-driven CS. Though in current implementation the driver fallback to using normal
push-pull IO mode if GPIO CS is utilized as safer one. But even in this case
it's better than splitting the memory operations up into the transfers, which is
developed in the spi_mem_exec_op() method.

So in this matter my question is: how to modify the SPI-mem interface so the
SPI-memory operations would also work with GPIO driven CS? Some additional flag
might work...

Thirdly what about dirmap operations? If we got a GPIO driven CS then due to
lacking any CS manipulation in spi_mem_dirmap_read() method we wouldn't have
been able to make the direct mapping working without manual setting the GPIO.
So the same question here. How to work this around and justify your requirement?
Until the question is answered and we come up with reasonable solution in order
to have the SPI-mem/dirmap interface working together with GPIO CS support I have
to leave the manual GPIO manipulation.

> 
> > +	} else if (!req->dirmap) {
> > +		local_irq_save(bs->cfg.flags);
> > +		preempt_disable();
> > +	}
> 

> This is obviously not great, especially for larger transfers.

Don't tell me about this. But this is the only way to make the controller
working with all the weird stuff it has got.

> It would
> be a lot easier to review and manage this if the IRQ disabling was done
> around the transfers in a single function rather than separately, that
> way everything is next to each other and it's clearer that we're doing
> this for the minimum time and didn't miss anything.  Right now it's hard
> to tell if everything is joined up.

Hm, this is questionable. If it wasn't joined up I wouldn't have the driver
working. Anyway I see your point and from a different angle of view this might be
better to move this operations to the bs_exec_mem_op() method. But if you insist
on implementing the full SPI-message interface support even for native CS, I'd
leave it here to avoid the code duplication, since the IRQs disabling workaround
should be also used there.

> 
> > +static void bs_update_cfg(struct bt1_spi *bs, struct spi_transfer *xfer)
> > +{
> 
> This has exactly one caller, perhaps it could just be inlined there?  I
> think this applies to some of the other internal functions.

I don't want to inline methods just because they are used in a single place. This
might worsen readability and in this case it will. Currently the transfer_one()
method is consistent with self-explanatory methods: update config, push-pull
bytes/words, check status. This also applies to the rest of the code. I can
consider some improvements/optimizations in this matter though, but embedding
the functions isn't one of them. Moreover the compiler does the static
methods inlining automatically as soon as it sees they are called just once.

> 
> > +static int bs_check_status(struct bt1_spi *bs)
> > +{
> 
> It's not obvious from the name that this function will busy wait rather
> than just reading some status registers.

What do you suggest then? Renaming? Splitting up? If renaming, then what name do
you prefer? Something like bs_check_completion()?

> 
> > +	/*
> > +	 * Spin around the BUSY-state bit waiting for the controller to finish
> > +	 * all the requested IO-operations.
> > +	 */
> > +	do {
> > +		data = readl(bs->regs + BC_SPI_SR);
> > +	} while ((data & BC_SPI_SR_BUSY) || !(data & BC_SPI_SR_TFE));
> 
> We could use a timeout or something here in case something goes wrong,
> as things stand we could end up spinning for ever.

Ok. readl_poll_timeout_atomic() shall do the trick.

> 
> It's also not clear to me why we only check for over/underrun before we
> do the busy wait, especially a RX overrun could happen and cause us to
> loose data while things are finishing up.

In fact this busy-wait loop is relevant for the Tx-only operations. So here we
are waiting for the controller to push the rest of the data from FIFO to the
bus. This is necessary so the next IO operation wouldn't clear the FIFO up by
disabling the controller at the bs_set_cfg() method. The busy-wait loop shall
not cause any overruns (because Rx is turned off). If Tx/Rx overrun happened
it must have happened before and only If either the IO algorithm couldn't keep
up with data being pushed out/pulled in to/from the FIFOs (SPI bus is too fast
while MMIO operations are too slow or for some other case) or I messed
something up with the IO algorithm implementation.

Anyway in order to prevent such question from future code readers I'll move the
busy-wait loop in the beginning of the function.

> 
> > +	while (txlen || rxlen) {
> > +		cnt = BC_SPI_FIFO_LVL - __raw_readl(bs->regs + BC_SPI_TXFLR);
> > +		cnt = min(cnt, txlen);
> > +		txlen -= cnt;
> > +		while (cnt--) {
> > +			data = src ? *src++ : 0xFF;
> > +			__raw_writel(data, bs->regs + BC_SPI_DR);
> > +		}
> 
> It's more typical to write zeros when there's no data.

Ok.

> 
> > +static int bs_exec_mem_op(struct spi_mem *mem,
> > +			  const struct spi_mem_op *op)
> > +{
> 
> It's not clear to me that this hardware actually supports spi_mem in
> hardware?

SPI-mem operations are implemented by means of the EEPROM-read and Tx-only
modes of the controller.
 
> 
> > +	if (!bs->cfg.cs_gpiod) {
> > +		bs_push_bytes(bs, cmd, len);
> > +
> > +		if (op->data.dir == SPI_MEM_DATA_IN)
> > +			ret = bs_pull_bytes(bs, op->data.buf.in,
> > +					    op->data.nbytes);
> > +	} else {
> > +		bs_pp_bytes(bs, cmd, NULL, len);
> > +
> > +		if (op->data.dir == SPI_MEM_DATA_IN)
> > +			bs_pp_bytes(bs, NULL, op->data.buf.in,
> > +				    op->data.nbytes);
> > +	}
> 

> The actual transfers here are done using the same PIO functions as
> everything else as far as I can see which makes me wonder what this
> spi_mem implementation is adding over the standard SPI flash support.

No, if no GPIO CS is supplied the memory read operation is performed by means of
the EEPROM-read mode of the DW SSI controller (Write command is written to the
Tx FIFO and read data length - to the CTRLR1 register). The memory write
operation utilizes the Tx-only mode (just push data to the Tx FIFO, controller
discards all incoming data). See bs_set_cfg() for details.

If GPIO CS is utilized then we fallback to the normal push-pull methods because
first it's safer this way, second it's still better than handling multiple SPI
transfers.

BTW The EEPROM/Tx-only modes are required to be utilized for the controller on
our SoC in order to support the SPI bus operations with highest frequencies.
Due to relatively slow APB bus performance we have to minimize MMIO operation
per a single byte read/write. This is another reason why we had to create a
dedicated driver for this controller.

> I've not checked but if we need this to get the dirmap support to kick
> in then we should fix this by making the core not have that requirement.

No, dirmap is implemented by means of dedicated sub-block of the boot
controller, which does all of the IO by itself (though the controller config
still has to be accordingly setup including CS or GPIO CS). We just read a
ready SPI-flash data from a dedicated MMIO space.

> 
> > +static void bs_copy_from_map(void *to, void __iomem *from, size_t len)
> > +{
> > +	size_t shift, chunk;
> > +	u32 data;
> 
> This feels like something that is likely to be suitable for a generic
> implementation?  Indeed I'd kind of expect that the architecture
> memcpy_to/fromio() would try to copy aligned blocks since it's usually
> going to perform better (which I assume is why this function is doing
> it).

MIPS memcpy_to/fromio don't do this. They expect the MMIO space can be read in
a same way as normal memory space. It's our controller "feature", that MMIO can
be only accessible by lw/sw instructions. So I had no choice but to implement the
aligned read/write operations by myself here. AFAICS this won't be suitable for
the generic implementation due to the alignment restriction and the controller
setups, which are supposed to be performed before accessing the dirmap MMIO.

> 
> > +	if (shift) {
> > +		chunk = min_t(size_t, 4 - shift, len);
> > +		data = readl_relaxed(from - shift);
> > +		memcpy(to, &data + shift, chunk);
> 
> It's a little unclear what we're actually doing though - we read a data
> address from the hardware?

As I've written in the comment:
 * We split the copying up into the next three stages: unaligned head,
 * aligned body, unaligned tail.
here we do the unaligned head read operation. I read data from an aligned
address, then copy the requested part to the output buffer.

> 
> > +static int bs_prepare_message(struct spi_controller *ctrl,
> > +			      struct spi_message *msg)
> > +{
> > +	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
> > +	struct spi_transfer *xfer;
> > +	struct bt1_spi_cfg req;
> > +
> > +	/*
> > +	 * Currently the driver doesn't support the generic messages-based
> > +	 * SPI interface with pure native chip-select signal. This is due
> > +	 * to the automatic native chip-select toggle peculiarity described
> > +	 * in the comment of the bs_set_cfg() method. Alas we can't use the
> > +	 * IRQ-disable-based boost approach here since the native queue-based
> > +	 * SPI messages transfer method can sleep waiting for the
> > +	 * transfers/CS-change delays.
> > +	 */
> > +	if (!msg->spi->cs_gpiod)
> > +		return -ENOTSUPP;
> 
> This seems a bit much - we can validate that the message doesn't contain
> any delays (which is going to be the overwhelming majority of devices)
> or multiple transfers and reject just those transfers we can't support.
> Multiple transfers are an issue with this hardware but you could
> implement support in the core for coalescing them into single transfers,
> this isn't the only hardware with automatic chip select handling that
> can't cope with scatter/gather so it would be a useful thing to have.

As I said in the commit message to the binding this controller is nearly always
connected to an external SPI flash (I'd say always, because Baikal-T1 is fully
functional only when initially booted from an SPI flash). At least I don't know
any hardware using this interface differently (I've worked with all devices with
Baikal-T1 SoC on board). In current driver implementation the SPI-mem operations
covers the native CS case while the prepare_message()/transfer_one()/unprepare_message()
are used when GPIO-driven CS is available (due to the commit 05766050d5bd I had
to implement it). So I didn't want to over-complicate the driver just to support
some virtual hardware before it's really necessary.

> 
> > +	/*
> > +	 * Collect the controller configuration common for all transfers and
> > +	 * specific to the very first one.
> > +	 */
> > +	xfer = list_first_entry(&msg->transfers, typeof(*xfer), transfer_list);
> > +	req.dirmap = false;
> > +	req.cs = msg->spi->chip_select;
> > +	req.cs_gpiod = msg->spi->cs_gpiod;
> > +	req.flags = 0;
> > +	req.mode = msg->spi->mode;
> > +	req.tmode = BC_SPI_CTRL0_TMOD_TR;
> > +	req.ndf = 0;
> > +	req.dfs = xfer->bits_per_word;
> > +	req.freq = xfer->speed_hz;
> > +
> > +	bs_set_cfg(bs, &req);
> 
> It's not clear to me what the benefit is in this indirection through
> req?

Config request is useful to collect the controller configs in a single
structure from different objects like normal SPI transfers, SPI-mem
operations or dirmaps. The config structure is then uniformly translated
into the controller setting by the bs_set_cfg() method. 

> 
> > +static int bs_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
> > +			   struct spi_transfer *xfer)
> > +{
> > +	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
> > +
> > +	bs_update_cfg(bs, xfer);
> > +
> > +	if (bs->cfg.dfs <= 8)
> > +		bs_pp_bytes(bs, xfer->tx_buf, xfer->rx_buf, xfer->len);
> > +	else
> > +		bs_pp_words(bs, xfer->tx_buf, xfer->rx_buf, xfer->len / 2);
> 
> This will have issues with transfers with an odd number of bytes won't
> it?

No, it won't. Transfers with bits per word greater than 8 should have even
number of bytes seeing the len field is supposed to have the buffers length in
bytes:

 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len = 2N) and hold N sixteen bit words in CPU byte order.
 *
 * When the word size of the SPI transfer is not a power-of-two multiple
 * of eight bits, those in-memory words include extra bits.  In-memory
 * words are always seen by protocol drivers as right-justified, so the
 * undefined (rx) or unused (tx) bits are always the most significant bits.

The controller expects exactly the same interpretation of right-justified data
when its length isn't not power of 2 including the extra bits.

> 
> > +static struct bt1_spi *bs_create_data(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct bt1_spi *bs;
> 
> As with some of the other functions this has exactly one caller and
> barely any content in it, just inline it.

As I said before. I don't see this being necessary.

> 
> > +	bs->dev = dev;
> > +	bs->pdev = pdev;
> 
> Do you really need to separately save these (and is there a context
> where you have the driver data but not the device anyway)?

Even if I don't, having a device pointer around in the private data is a
matter of convenience. It's either referencing the controller/mem pointers
cascade to get it, which may look bulky like &mem->controller->dev and having
an additional argument passed to the sub-functions and in some cases allocating
pointers on the stack; or to prevent all of these complications I just save the
device structure pointer in the private data, so to use it when I need to print
an error or allocate dev-res, etc.

Regarding the platform_device pointer. Well I've defined it in the private data
for the same reason. Though it's used much less than generic device pointer, so
I can discard it.

> 
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define BC_SPI_DBGFS_REG(_name, _off)	\
> > +{					\
> > +	.name = _name,			\
> > +	.offset = _off			\
> > +}
> 
> Perhaps consider regmap_mmio?

For multiple reasons no. First of all I need a direct access to the DR register
and I need to do this as fast as possible due to relatively slow APB
bus. The same concern is regarding the controller configs setting. Secondly
everywhere in the driver I use the normal read/write methods and there is no
need in even a basic regmap-update function. So an additional abstraction like
regmap would be unnecessary complication. Thirdly the access to the registers
is always done from a thread-safe context anyway (except DebugFS read operations).
Fourthly due to the dirmap access the DW SSI registers can be unavailable at the
moment of the dirmap read method invocation, that's why I need a mutual exclusive
control around the operations concerning the registers. Due to this the regmap_mmio
won't work here and I would have to implement my own accessors. There might be
another problems, so using regmap isn't a good idea.

> 
> > +static int bs_dbgfs_open_regs(struct inode *inode, struct file *file)
> > +{
> > +	struct bt1_spi *bs = inode->i_private;
> > +	int ret;
> > +
> > +	ret = single_open(file, bs_dbgfs_show_regs, bs);
> > +	if (!ret) {
> > +		mutex_lock(&bs->ctrl->io_mutex);
> 
> Holding a mutex over the entire time that a file is open is not good,
> it's also not clear to me what this mutex is supposed to be protecting
> given that it's only referenced in these debugfs functions.

Hm, it's io_mutex protecting the SPI IO operation to be thread-safe. See:
spi_mem_access_start()/spi_mem_access_end();
__spi_pump_messages();

By locking the mutex here I make sure the DebugFS registers dump operation won't
interfere the IO operations like dirmap, which make the registers unavailable
for normal MMIO-based access.

> 
> > +		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);
> 
> Whatever this write is doing we never seem to undo it?

Here I switch on the DW APB SSI registers to be available for normal
readl/writel accesses. It's not a problem to leave the mode on, since
bs_set_cfg() will do a proper config anyway.


Wow, what a thorough review...

-Sergey

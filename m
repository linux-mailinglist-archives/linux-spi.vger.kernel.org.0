Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47931D6E33
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 02:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgERAF4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 17 May 2020 20:05:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43746 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERAFz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 17 May 2020 20:05:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 06E488030802;
        Mon, 18 May 2020 00:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XBFMYiXA6VTe; Mon, 18 May 2020 03:05:44 +0300 (MSK)
Date:   Mon, 18 May 2020 03:05:42 +0300
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
Message-ID: <20200518000542.ohtpem3lo2pbixbu@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
 <20200511212506.GA23852@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511212506.GA23852@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark,
I give up.) I'll try to integrate what I've done here in the generic DW APB SSI
driver framework. Then add some hooks so to support our specific DW APB SSI
controller. The I create a glue-layer for it. My answers to you comments are
below.

On Mon, May 11, 2020 at 10:25:06PM +0100, Mark Brown wrote:
> On Sun, May 10, 2020 at 03:20:39AM +0300, Serge Semin wrote:
> > On Fri, May 08, 2020 at 12:37:51PM +0100, Mark Brown wrote:
> 
> > > Your CC list on this series is *very* wide - are you sure that this is
> > > relevant to everyone you're sending things to?  Kernel developers often
> > > get a lot of mail meaning that extra mail can become a bit overwhelming
> > > and cause things to get lost in the noise.
> 
> > MIPS folks are here since Baikal-T1 is a MIPS-based chip and this patchset
> > is a part of the campaign of integrating the SoC support into the kernel.
> > With Lee and Miquel we discussed the dirmap support in the framework of another
> > patchset. Rob and devicetree-list are CC'ed due to having the bindings tree
> > updated. Then a series of folks who recently submitted the biggest updates into
> > the spi subsystems so might have valuable comments for this driver as well. So
> > yes, I am sure.
> 
> I think you've got too many people who've been contributing to the
> subsystem here at least - it looks like you picked up some people who
> recently wrote drivers but haven't been doing a lot of review for
> example for example.
> 
> > Anyway ok. I'll fix it. Is it ok to have the C-style comments in the header
> > file?
> > * It isn't included by any assembly so from this point of view C++ style
> > * shall also work there.
> 
> The SPDX stuff requires C style comments in headers so yes.
> 
> > Secondly the message of that commit states "Devices with chip selects driven
> > via GPIO are not compatible with the spi-mem operations." I find this statement
> > questionable, because for instance this device supports memory operations with
> > GPIO-driven CS. Though in current implementation the driver fallback to using normal
> > push-pull IO mode if GPIO CS is utilized as safer one. But even in this case
> > it's better than splitting the memory operations up into the transfers, which is
> > developed in the spi_mem_exec_op() method.
> 
> > So in this matter my question is: how to modify the SPI-mem interface so the
> > SPI-memory operations would also work with GPIO driven CS? Some additional flag
> > might work...
> 

> Yes, some flags should work here - the issue was that at least some
> controllers may end up trying to do multiple SPI operations for one
> spi-mem thing which will break if the chip select doesn't get changed to
> correspond with what's going on.

Ok. New SPI flag it is then. It will be something like this:
+ #define SPI_CONTROLLER_FLASH_SS		BIT(6)

Then we have to convert spi_set_cs() method to be non-static in the spi.c
to be used in the spi-mem.c to properly select slaves

Then the spi_mem_access_start() and spi_mem_access_stop() of spi-mem.c should be
updated in the following way:
--- spi_mem_access_start()
+++ spi_mem_access_start()
 
 	mutex_lock(&ctlr->bus_lock_mutex);
 	mutex_lock(&ctlr->io_mutex);
+
+	if (ctlr->flags & SPI_CONTROLLER_FLASH_SS)
+		spi_set_cs(mem->spi, true);
 
 	return 0;
 }
--- spi_mem_access_end()
+++ spi_mem_access_end()
 static void spi_mem_access_end(struct spi_mem *mem)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->flags & SPI_CONTROLLER_FLASH_SS)
+		spi_set_cs(mem->spi, false);
 
 	mutex_unlock(&ctlr->io_mutex);
 	mutex_unlock(&ctlr->bus_lock_mutex);
---

Method spi_mem_exec_op() shall also make sure that even if GPIO-driven CS is
utilized the normal mem-op is executed. Something like this should do this:
--- spi_mem_exec_op()
+++ spi_mem_exec_op()
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
 
-	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
+	if (ctlr->mem_ops &&
+	    (!mem->spi->cs_gpiod || (ctlr->flags & SPI_CONTROLLER_FLASH_SS))) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
---

So, what do you think?

> 
> > Thirdly what about dirmap operations? If we got a GPIO driven CS then due to
> > lacking any CS manipulation in spi_mem_dirmap_read() method we wouldn't have
> > been able to make the direct mapping working without manual setting the GPIO.
> > So the same question here. How to work this around and justify your requirement?
> > Until the question is answered and we come up with reasonable solution in order
> > to have the SPI-mem/dirmap interface working together with GPIO CS support I have
> > to leave the manual GPIO manipulation.
> 
> If the issue with ensuring that chip select is managed appropriately for
> transfers can be resolved then push that stuff up to the framework.  If
> not then it's not clear that the open coded version can work well
> with GPIO chip selects either.

See the comment above.

> 
> > > > +static void bs_update_cfg(struct bt1_spi *bs, struct spi_transfer *xfer)
> > > > +{
> 
> > > This has exactly one caller, perhaps it could just be inlined there?  I
> > > think this applies to some of the other internal functions.
> 
> > I don't want to inline methods just because they are used in a single place. This
> > might worsen readability and in this case it will. Currently the transfer_one()
> > method is consistent with self-explanatory methods: update config, push-pull
> > bytes/words, check status. This also applies to the rest of the code. I can
> > consider some improvements/optimizations in this matter though, but embedding
> > the functions isn't one of them. Moreover the compiler does the static
> > methods inlining automatically as soon as it sees they are called just once.
> 
> One of the things that creating internal APIs like this does is that it
> adds another layer of structure to the driver, making it a bit harder to
> follow that it's following the usual structures of a Linux driver
> (especially noticable here given the open coding).  It creates the
> impression of the platform portability layers that people sometimes try
> to build.

Let's stop this discussion.) Since I am going to integrate this patch into the
generic DW APB SSI driver, I will have to follow that driver design anyway. So
most likely I won't implement a new handy abstraction.

> 
> > > > +static int bs_check_status(struct bt1_spi *bs)
> > > > +{
> 
> > > It's not obvious from the name that this function will busy wait rather
> > > than just reading some status registers.
> 
> > What do you suggest then? Renaming? Splitting up? If renaming, then what name do
> > you prefer? Something like bs_check_completion()?
> 
> wait_for_completion() or something else that mentions that it will wait
> for completion rather than just looking to see if the operation has
> completed.

Ok. If it will be still applicable.

> 
> > > > +static int bs_exec_mem_op(struct spi_mem *mem,
> > > > +			  const struct spi_mem_op *op)
> > > > +{
> 
> > > It's not clear to me that this hardware actually supports spi_mem in
> > > hardware?
> 
> > SPI-mem operations are implemented by means of the EEPROM-read and Tx-only
> > modes of the controller.
> 
> Sure, but those seem like normal SPI-level things rather than cases
> where the hardware understands that it has a flash attached and is doing
> flash specific things.

No, hardware can't detect whether the flash is attached. This must be defined by
the platform, like based on the DT sub-nodes.

> A very common case for this stuff is that
> controllers have acceleration blocks for read and fall back on normal
> SPI for writes and erases, that sounds like what's going on here.

Well, yeah, they do provide some acceleration. EEPROM-read provides automatic
write-cmd-dummy-data-then-read operations. But in this case the only thing we
have to push into the SPI Tx FIFO is command and dummy bytes. The read operation
will be performed automatically. So the only thing the driver has to do is to
keep up with Rx FIFO data pulling out before it's overflown. Similarly Tx-only
mode is used to perform the Flash write/erase commands. The driver has to keep up
with pushing data into the Tx FIFO before it gets emptied and CS is de-asserted.
Using these operations is mandatory in case if there is no GPIO-driven CS is
utilized, since native CS is automatically asserted during the whole EEPROM-read
or Tx-only mode executed.

As I also said such operations are very useful, since minimize IO operations
performed over the APB bus. By doing so we can support higher SPI bus
frequencies.

> 
> > > > +	if (!bs->cfg.cs_gpiod) {
> > > > +		bs_push_bytes(bs, cmd, len);
> > > > +
> > > > +		if (op->data.dir == SPI_MEM_DATA_IN)
> > > > +			ret = bs_pull_bytes(bs, op->data.buf.in,
> > > > +					    op->data.nbytes);
> > > > +	} else {
> > > > +		bs_pp_bytes(bs, cmd, NULL, len);
> > > > +
> > > > +		if (op->data.dir == SPI_MEM_DATA_IN)
> > > > +			bs_pp_bytes(bs, NULL, op->data.buf.in,
> > > > +				    op->data.nbytes);
> > > > +	}
> > > 
> 
> > > The actual transfers here are done using the same PIO functions as
> > > everything else as far as I can see which makes me wonder what this
> > > spi_mem implementation is adding over the standard SPI flash support.
> 
> > No, if no GPIO CS is supplied the memory read operation is performed by means of
> > the EEPROM-read mode of the DW SSI controller (Write command is written to the
> > Tx FIFO and read data length - to the CTRLR1 register). The memory write
> 
> So EEPROM read mode is a combined write/read - is that somehow less
> performant or something than separate opeations so there's a reason not
> to use it except in this special circumstance?

Actually It's more performant (less APB-bus MMIO operations required to perform
the transfers) and safer in case of Native CS-driven slave devices. In case of
GPIO-driven CS EEPROM and Tx-only are still more performant modes, but less safe
than normal synchronous SPI Tx/Rx mode.

I'll explain it one more time to logically continue this discussion. In general
the DW APB SSI controller may be utilized on two types of platform setups:

1) A slave device is selected by the DW APB SSI Native CS lane only.

You know, that Dw APB SSI native chip select is automatically asserted by the
SPI controller during a transfer being executed. As soon as there is no data in
the Tx FIFO to transfer (Tx-only or Tx-Rx modes) or there is no data left to
receive (EEPROM-read or Rx-only mode), the native CS will be automatically
de-asserted.

If we decided not to implement the mem-ops in the driver, then we'd have to:
for flash-write operation: analyze the passed message ahead, merge the Tx-only
operations and atomically execute them after activating Tx-only mode;
for flash-read operation: analyze the passed message ahead, merge Tx-only
operations, combine it with Rx-only tail part and atomically execute them all
after activating the EEPROM-read mode. Well, what we've done here is basically
a reverse operation performed by the spi_exec_mem_op(), which just split the
spi_mem_op structure up into a set of spi_transfer's. Why would we need to do
this, while we could just use the already provided perfectly suitable spi_mem_op
data structure for our needs? Especially seeing our controller supports the
operations like Tx-only and EEPROM-read specifically provided for the cases
of flash-device write/read operations. Isn't that a reason of claiming that it
supports mem-ops?

If we decided to implement the mem-ops in the driver (as it's done in this
patch), then the only thing we'd need to do is to enable the corresponding DW APB
SSI controller mode and push or push/pull spi_mem_op data on time. That's it.
No remapping, no data analyzing, no merging. Yes, the hardware doesn't provide
that much acceleration than normal Flash-capable SPI controllers, but still
it's better than handling standard transfers.

You'd say why remapping, analyzing and merging? Just use the normal SPI
synchronous Tx/Rx mode and push dummy zeros or ignore incoming data. The answer
is performance. Well, this might be good solution if the APB bus was fast enough.
If it's not, then we have to minimize the IO operations with Dw APB SSI
registers. This can be only done by using the EEPROM-read and Tx-only mode utilized. 

Note, all the operations described above MUST be executed in the atomic context,
so the data push/pull algorithms would keep up with keeping the Tx FIFO
non-empty and preventing the Rx FIFO overflown by automatically incoming data.
If either for a reason of IRQ or another task preemption or due to the slow APB
bus we get the Tx FIFO emptied, then the native CS will be de-asserted. If for
the same reason we get the Rx FIFO overflown, then we'll loose data.

2) A slave is selected by GPIO CS.

Well, TBH in this case it's still more performant to use the Tx-only and
EEPROM-read modes for communications (because we need less APB bus activity),
but these modes mandate the IRQs disabling since data is automatically
received. Since in this case the problem with automatic CS de-assertion doesn't
exist (we can manually set and clear GPIO CS), it is safe to use the normal
synchronous SPI Tx/Rx mode and avoid IRQs disabling. Though in case if better
performance is required then mem-ops should be utilized.


Note using Tx-only and EEPROM-read operations is more performant than
normal synchronous SPI Tx-Rx mode because it causes less APB bus activity.
In addition we need less data analyzing and mapping for spi-mem operations.
In our case both of these factors are very important due to slow APB bus.

(See further comment for details of what I can port from this driver to the
generic DW APB SSI core.)

> 
> > operation utilizes the Tx-only mode (just push data to the Tx FIFO, controller
> > discards all incoming data). See bs_set_cfg() for details.
> 
> That's not super illuminating on this issue?
> 
> > If GPIO CS is utilized then we fallback to the normal push-pull methods because
> > first it's safer this way, second it's still better than handling multiple SPI
> > transfers.
> 
> > BTW The EEPROM/Tx-only modes are required to be utilized for the controller on
> > our SoC in order to support the SPI bus operations with highest frequencies.
> > Due to relatively slow APB bus performance we have to minimize MMIO operation
> > per a single byte read/write. This is another reason why we had to create a
> > dedicated driver for this controller.
> 
> If the controller has support for TX only mode that seems like a good
> thing to have in the generic driver - for TX only transfers that's less
> bus I/O.  The EEPROM mode potentially also, I'm less clear on what
> exactly it is but it sounds potentially useful for common cases with
> register operations.  Perhaps other systems might have similarly slow
> buses and get noticable performance benefits from using these modes.

See my comments above. I gave up and will try to merge my driver into the
generic Dw APB SSI framework.

> 
> > > > +static void bs_copy_from_map(void *to, void __iomem *from, size_t len)
> > > > +{
> > > > +	size_t shift, chunk;
> > > > +	u32 data;
> 
> > > This feels like something that is likely to be suitable for a generic
> > > implementation?  Indeed I'd kind of expect that the architecture
> > > memcpy_to/fromio() would try to copy aligned blocks since it's usually
> > > going to perform better (which I assume is why this function is doing
> > > it).
> 
> > MIPS memcpy_to/fromio don't do this. They expect the MMIO space can be read in
> > a same way as normal memory space. It's our controller "feature", that MMIO can
> > be only accessible by lw/sw instructions. So I had no choice but to implement the
> > aligned read/write operations by myself here. AFAICS this won't be suitable for
> > the generic implementation due to the alignment restriction and the controller
> > setups, which are supposed to be performed before accessing the dirmap MMIO.
> 
> You should document this in the driver so nobody comes along and does
> the refactoring as a cleanup, it looks like duplicated or redundant code.

Ok.

> 
> > > This seems a bit much - we can validate that the message doesn't contain
> > > any delays (which is going to be the overwhelming majority of devices)
> > > or multiple transfers and reject just those transfers we can't support.
> > > Multiple transfers are an issue with this hardware but you could
> > > implement support in the core for coalescing them into single transfers,
> > > this isn't the only hardware with automatic chip select handling that
> > > can't cope with scatter/gather so it would be a useful thing to have.
> 
> > As I said in the commit message to the binding this controller is nearly always
> > connected to an external SPI flash (I'd say always, because Baikal-T1 is fully
> > functional only when initially booted from an SPI flash). At least I don't know
> > any hardware using this interface differently (I've worked with all devices with
> > Baikal-T1 SoC on board). In current driver implementation the SPI-mem operations
> > covers the native CS case while the prepare_message()/transfer_one()/unprepare_message()
> > are used when GPIO-driven CS is available (due to the commit 05766050d5bd I had
> > to implement it). So I didn't want to over-complicate the driver just to support
> > some virtual hardware before it's really necessary.
> 
> Aside from the issue of tempting fate in board designs this circles back
> to the open coding of the bits of the spi-mem stuff that aren't really
> offloaded by the hardware - the driver would look a lot more standard
> (and be closer to spi-dw I guess) if it only implemented the bits that
> are offloaded and this interface was available.  Having the normal
> SPI message interface would not only support non-flash hardware, it'd
> also enable the use of more of the generic SPI flash code like other
> similar controllers.

See my comment above, why it's necessary to have the spi-mem implemented for
the case of native CS. If GPIO-driven CS is utilized, then generic (synchronous
SPI Tx/Rx mode) but poll-based (since there is no IRQ provided for our controller)
algorithm can be utilized. If native CS is only available, then the safest way
is to have the atomic context by disabling the interrupts. This can be easily
done for the spi-mem interface, but nearly impossible for the generic
spi_transfer_one_message()-based IO. The only alternative is to implement the
device-specific transfer_one_message() callback, analyze SPI transfers,
merge them up, execute in the atomic context. Needless to say, that such approach
is only applicable for the IRQless controllers. If IRQ is available for the
controller, then using Native CS is still unsafe.

To sum up what approaches are better in what configurations if IRQ-less DW APB
SSI controller is available:
1) Flash/spi-mem + Native CS => EEPROM-read/Tx-only + atomic context - disable IRQs.
2) Flash/spi-mem + GPIO CS   => normal synchronous SPI Tx/Rx mode (currently this
                                will fallback to 4) because spi_mem_exec_op()
                                implementation, probably for good).
3) SPI msg + Native CS => reimplement transfer_one_message() + merge transfers
                          if possible otherwise use normal Tx+Rx mode + atomic
                          context - disabling IRQs during the whole message.
4) SPI msg + GPIO CS   => normal synchronous SPI Tx/Rx mode.

For the Dw APB SSI controller with IRQ the 2) and 4) items are the same. 1) and
3) can't be safely implemented due to possible concurrent IRQs.

Item 4) is already available in the current spi-dw.c driver, although the poll-mode
has been recently removed (I'll have to get it back). From this patch I can port the
items 1) and 2) to the generic version of the DW APB SSI driver. I won't spend
my time for 3) because first I've already spent a lot of it on implementing this
driver, second I don't need such functionality on our platforms. If someone ever
needs it, I'll assist with an advice of how to do this.

So, what do you think?

> 
> > > > +static int bs_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
> > > > +			   struct spi_transfer *xfer)
> > > > +{
> > > > +	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
> > > > +
> > > > +	bs_update_cfg(bs, xfer);
> > > > +
> > > > +	if (bs->cfg.dfs <= 8)
> > > > +		bs_pp_bytes(bs, xfer->tx_buf, xfer->rx_buf, xfer->len);
> > > > +	else
> > > > +		bs_pp_words(bs, xfer->tx_buf, xfer->rx_buf, xfer->len / 2);
> > > 
> > > This will have issues with transfers with an odd number of bytes won't
> > > it?
> 
> > No, it won't. Transfers with bits per word greater than 8 should have even
> > number of bytes seeing the len field is supposed to have the buffers length in
> > bytes:
> 
> So dfs is bits per word?  This is one of those things where the internal
> APIs make things harder to follow.
> 
> > > Perhaps consider regmap_mmio?
> 
> > For multiple reasons no. First of all I need a direct access to the DR register
> > and I need to do this as fast as possible due to relatively slow APB
> > bus. The same concern is regarding the controller configs setting. Secondly
> > everywhere in the driver I use the normal read/write methods and there is no
> > need in even a basic regmap-update function. So an additional abstraction like
> > regmap would be unnecessary complication. Thirdly the access to the registers
> 
> That comment was more due to writing debug infrastructure than stuff
> like update_bits - the main reason regmap-mmio exists is for the debug
> and cache features.  If the performance is too marginal to allow any
> overhead then fine.  There's nothing stopping you combining regmap and
> non-regmap on the same device if you exclude the more sensitive
> registers from regmap with the access operations but it's not exactly
> nice.
> 
> > > > +	if (!ret) {
> > > > +		mutex_lock(&bs->ctrl->io_mutex);
> 
> > > Holding a mutex over the entire time that a file is open is not good,
> > > it's also not clear to me what this mutex is supposed to be protecting
> > > given that it's only referenced in these debugfs functions.
> 
> > Hm, it's io_mutex protecting the SPI IO operation to be thread-safe. See:
> > spi_mem_access_start()/spi_mem_access_end();
> > __spi_pump_messages();
> 
> > By locking the mutex here I make sure the DebugFS registers dump operation won't
> > interfere the IO operations like dirmap, which make the registers unavailable
> > for normal MMIO-based access.
> 
> Oh, it's the SPI level mutex...  that is a bit icky, and it does let
> userspace code block the bus fairly easily which could be problematic
> but I guess it's debugfs so meh.

Ok.

> 
> > > > +		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);
> 
> > > Whatever this write is doing we never seem to undo it?
> 
> > Here I switch on the DW APB SSI registers to be available for normal
> > readl/writel accesses. It's not a problem to leave the mode on, since
> > bs_set_cfg() will do a proper config anyway.
> 
> A comment would help here, the fact that it's not undone looks like a
> bug.

Ok.

-Sergey

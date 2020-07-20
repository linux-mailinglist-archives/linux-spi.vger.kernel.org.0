Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94A7226AFD
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGTQiO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 12:38:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:15323 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388950AbgGTQiL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 12:38:11 -0400
X-Originating-IP: 42.109.212.217
Received: from localhost (unknown [42.109.212.217])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7114824000E;
        Mon, 20 Jul 2020 16:38:04 +0000 (UTC)
Date:   Mon, 20 Jul 2020 22:08:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        matthias.bgg@gmail.com, michal.simek@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, boris.brezillon@collabora.com,
        nsekhar@ti.com
Subject: Re: [PATCH v10 07/17] mtd: spi-nor: sfdp: parse xSPI Profile 1.0
 table
Message-ID: <20200720163802.veql43cmal7sunit@yadavpratyush.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-8-p.yadav@ti.com>
 <1450d8c8-cda4-51e3-9f57-0b2f00825f11@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450d8c8-cda4-51e3-9f57-0b2f00825f11@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 08/07/20 04:01PM, Tudor.Ambarus@microchip.com wrote:
> On 6/23/20 9:30 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > This table is indication that the flash is xSPI compliant and hence
> > supports octal DTR mode. Extract information like the fast read opcode,
> > dummy cycles, the number of dummy cycles needed for a Read Status
> > Register command, and the number of address bytes needed for a Read
> > Status Register command.
> > 
> > We don't know what speed the controller is running at. Find the fast
> > read dummy cycles for the fastest frequency the flash can run at to be
> > sure we are never short of dummy cycles. If nothing is available,
> > default to 20. Flashes that use a different value should update it in
> > their fixup hooks.
> > 
> > Since we want to set read settings, expose spi_nor_set_read_settings()
> > in core.h.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c |  2 +-
> >  drivers/mtd/spi-nor/core.h | 10 ++++
> >  drivers/mtd/spi-nor/sfdp.c | 98 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 109 insertions(+), 1 deletion(-)
> > 
[...]
> > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > index 3f709de5ea67..d5a24e61813c 100644
> > --- a/drivers/mtd/spi-nor/sfdp.c
> > +++ b/drivers/mtd/spi-nor/sfdp.c
[...]
> > @@ -66,6 +70,16 @@ struct sfdp_bfpt_erase {
> >         u32                     shift;
> >  };
> > 
> > +/* xSPI Profile 1.0 table (from JESD216D.01). */
> > +#define PROFILE1_DWORD1_RD_FAST_CMD            GENMASK(15, 8)
> > +#define PROFILE1_DWORD1_RDSR_DUMMY             BIT(28)
> > +#define PROFILE1_DWORD1_RDSR_ADDR_BYTES                BIT(29)
> > +#define PROFILE1_DWORD4_DUMMY_200MHZ           GENMASK(11, 7)
> > +#define PROFILE1_DWORD5_DUMMY_166MHZ           GENMASK(31, 27)
> > +#define PROFILE1_DWORD5_DUMMY_133MHZ           GENMASK(21, 17)
> > +#define PROFILE1_DWORD5_DUMMY_100MHZ           GENMASK(11, 7)
> 
> we should order these macros in a consistent way. I see that previous macros
> are declared in order starting from MSB to LSB.
> 
> > +#define PROFILE1_DUMMY_DEFAULT                 20
> 
> we need to explain why the default dummy value is 20.

No reason other than the fact that it is the default for the first flash 
that uses Profile 1.0 parsing (S28HS512T). AFAIK a similar reasoning is 
followed for the default being 8 for 1-1-4 or 1-1-8 modes.

I can't think of any reasonable way of deciding on a default value since 
it varies from flash to flash.
 
> How about declaring all these macros immediately above of spi_nor_parse_profile1()?
> 
> > +
> >  #define SMPT_CMD_ADDRESS_LEN_MASK              GENMASK(23, 22)
> >  #define SMPT_CMD_ADDRESS_LEN_0                 (0x0UL << 22)
> >  #define SMPT_CMD_ADDRESS_LEN_3                 (0x1UL << 22)
> > @@ -1106,6 +1120,86 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
> >         return ret;
> >  }
> > 
> > +/**
> > + * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @param_header:      pointer to the 'struct sfdp_parameter_header' describing
> > + *                     the 4-Byte Address Instruction Table length and version.
> > + * @params:            pointer to the 'struct spi_nor_flash_parameter' to be.
> > + *
> > + * Return: 0 on success, -errno otherwise.
> > + */
> > +static int spi_nor_parse_profile1(struct spi_nor *nor,
> > +                                 const struct sfdp_parameter_header *profile1_header,
> > +                                 struct spi_nor_flash_parameter *params)
> > +{
> > +       u32 *table, opcode, addr;
> 
> s/table/dwords?
> 
> u8 opcode?
> 
> > +       size_t len;
> > +       int ret, i;
> > +       u8 dummy;
> > +
> > +       len = profile1_header->length * sizeof(*table);
> > +       table = kmalloc(len, GFP_KERNEL);
> > +       if (!table)
> > +               return -ENOMEM;
> > +
> > +       addr = SFDP_PARAM_HEADER_PTP(profile1_header);
> > +       ret = spi_nor_read_sfdp(nor, addr, len, table);
> > +       if (ret)
> > +               goto out;
> > +
> > +       /* Fix endianness of the table DWORDs. */
> > +       for (i = 0; i < profile1_header->length; i++)
> > +               table[i] = le32_to_cpu(table[i]);
> 
> le32_to_cpu_array(table, profile1_header->length);
> 
> > +
> > +       /* Get 8D-8D-8D fast read opcode and dummy cycles. */
> > +       opcode = FIELD_GET(PROFILE1_DWORD1_RD_FAST_CMD, table[0]);
> > +
> > +       /*
> > +        * We don't know what speed the controller is running at. Find the
> > +        * dummy cycles for the fastest frequency the flash can run at to be
> > +        * sure we are never short of dummy cycles. A value of 0 means the
> > +        * frequency is not supported.
> > +        *
> > +        * Default to PROFILE1_DUMMY_DEFAULT if we don't find anything, and let
> > +        * flashes set the correct value if needed in their fixup hooks.
> > +        */
> > +       dummy = FIELD_GET(PROFILE1_DWORD4_DUMMY_200MHZ, table[3]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_166MHZ, table[4]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_133MHZ, table[4]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_100MHZ, table[4]);
> > +       if (!dummy)
> > +               dummy = PROFILE1_DUMMY_DEFAULT;
> > +
> > +       /* Round up to an even value to avoid tripping controllers up. */
> > +       dummy = ROUND_UP_TO(dummy, 2);
> > +
[...]

-- 
Regards,
Pratyush Yadav

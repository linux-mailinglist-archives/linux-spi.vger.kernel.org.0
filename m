Return-Path: <linux-spi+bounces-10753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B79BF65BF
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A637503790
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D83330331;
	Tue, 21 Oct 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMxTxbcP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC742ED86F;
	Tue, 21 Oct 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048100; cv=none; b=frYpfDl2k6op5rK+JkFctSzOQ5i+ExPqi1+uHdWlhZBH5KNZAnn7NwkObxv/Ka2tik0ak8MFekHdy5rIjrAone9M/Fzs4ko3iEaS3Nsk30QwJw8X9bc9GD969DbmTnz6dK95kr5NG7EgvSmtrzIuq7qactxS99779end7wed5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048100; c=relaxed/simple;
	bh=9pG0Mn3ypLcqh4wNtZ+d6HKDATOssi+vkxqoo/dolwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeAaBMHxk44AEtWfJ38S7DVsHtCckZjI5jOqbd1VYdVqzpGrvNUoidFvI1VZHZz0+F7p4J6A5FgKTQD6n20Z1omQMkh5/kNdnt5VYLHBrFn2AP6sYdZ2AVnYnWmi4YznFRbgIFMo1VBIht1M4F+oy+UnNLw/gcIQg/tx06nzuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMxTxbcP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761048098; x=1792584098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9pG0Mn3ypLcqh4wNtZ+d6HKDATOssi+vkxqoo/dolwg=;
  b=YMxTxbcPQp1QV0P6gnRiiGdg/x00FfdAMksON+qYrsrd3TtFuJWAZ8sY
   M2hLmq0DPM/I2E50azU5fyf7wiZIee8AuKBC1WFDNEuh0d/OVF/ES7ubt
   ZKZSU5zQs49kz8lngv3r7maURIZtYV9d2o5nTMjxoe9qmdw79u9jgJTMQ
   HvhawJYNT1SUGPoOLiahNm5b6lvyjyl4vyq1fYJFswxUVsc+i3KyjA0Dk
   /YVoh/nE6kFOonBKwv7rDedfaHLbu8jBz5ka0t2ukfzN3Z2t26NjGE1DO
   yG9pQ20O24c9l74MYFSXa7x6M8x51eKawQ+8lNTahMgr0jaTB3VkL+vWJ
   A==;
X-CSE-ConnectionGUID: ZYjJM6gsQwCdG1cWI1tPbg==
X-CSE-MsgGUID: v2FCR7thR3CbZ2yCYX2Dfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74513474"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="74513474"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:01:37 -0700
X-CSE-ConnectionGUID: aD2cF1LZR56tGmMso9RUqw==
X-CSE-MsgGUID: saXJNeyjRpC+85SiPEI2rw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2025 05:01:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBB3U-000Anx-1j;
	Tue, 21 Oct 2025 12:01:32 +0000
Date: Tue, 21 Oct 2025 20:01:13 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH] spi: spi-mem: Trace exec_op
Message-ID: <202510211959.kVCWipPy-lkp@intel.com>
References: <20251020190333.1431664-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020190333.1431664-1-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/spi-spi-mem-Trace-exec_op/20251021-030524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20251020190333.1431664-1-sean.anderson%40linux.dev
patch subject: [PATCH] spi: spi-mem: Trace exec_op
config: x86_64-buildonly-randconfig-003-20251021 (https://download.01.org/0day-ci/archive/20251021/202510211959.kVCWipPy-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510211959.kVCWipPy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510211959.kVCWipPy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
>> include/trace/events/spi-mem.h:42:22: error: too many arguments provided to function-like macro invocation
      42 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
>> include/trace/events/spi-mem.h:42:3: error: use of undeclared identifier '__assign_str'
      42 |                 __assign_str(name, mem->name);
         |                 ^
   include/trace/events/spi-mem.h:89:22: error: too many arguments provided to function-like macro invocation
      89 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
   include/trace/events/spi-mem.h:89:3: error: use of undeclared identifier '__assign_str'
      89 |                 __assign_str(name, mem->name);
         |                 ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:523:
>> include/trace/events/spi-mem.h:42:22: error: too many arguments provided to function-like macro invocation
      42 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:523:
   include/trace/events/spi-mem.h:89:22: error: too many arguments provided to function-like macro invocation
      89 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:133:
   In file included from include/trace/perf.h:110:
>> include/trace/events/spi-mem.h:42:22: error: too many arguments provided to function-like macro invocation
      42 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:133:
   In file included from include/trace/perf.h:110:
>> include/trace/events/spi-mem.h:42:3: error: use of undeclared identifier '__assign_str'
      42 |                 __assign_str(name, mem->name);
         |                 ^
   include/trace/events/spi-mem.h:89:22: error: too many arguments provided to function-like macro invocation
      89 |                 __assign_str(name, mem->name);
         |                                    ^
   include/trace/stages/stage6_event_callback.h:34:9: note: macro '__assign_str' defined here
      34 | #define __assign_str(dst)                                               \
         |         ^
   In file included from drivers/spi/spi-mem.c:16:
   In file included from include/trace/events/spi-mem.h:106:
   In file included from include/trace/define_trace.h:133:
   In file included from include/trace/perf.h:110:
   include/trace/events/spi-mem.h:89:3: error: use of undeclared identifier '__assign_str'
      89 |                 __assign_str(name, mem->name);
         |                 ^
   10 errors generated.


vim +42 include/trace/events/spi-mem.h

    13	
    14	#define decode_dtr(dtr) \
    15		__print_symbolic(dtr, \
    16			{ 0, "S" }, \
    17			{ 1, "D" })
    18	
    19	TRACE_EVENT(spi_mem_start_op,
    20		TP_PROTO(struct spi_mem *mem, const struct spi_mem_op *op),
    21		TP_ARGS(mem, op),
    22	
    23		TP_STRUCT__entry(
    24			__string(name, mem->name)
    25			__dynamic_array(u8, op, 1 + op->addr.nbytes + op->dummy.nbytes)
    26			__dynamic_array(u8, data, op->data.dir == SPI_MEM_DATA_OUT ?
    27						  min(op->data.nbytes, 64) : 0)
    28			__field(u32, data_len)
    29			__field(u32, max_freq)
    30			__field(u8, cmd_buswidth)
    31			__field(bool, cmd_dtr)
    32			__field(u8, addr_buswidth)
    33			__field(bool, addr_dtr)
    34			__field(u8, dummy_nbytes)
    35			__field(u8, data_buswidth)
    36			__field(bool, data_dtr)
    37		),
    38	
    39		TP_fast_assign(
    40			int i;
    41	
  > 42			__assign_str(name, mem->name);
    43			__entry->max_freq = op->max_freq ?: mem->spi->max_speed_hz;
    44	
    45			__entry->cmd_buswidth = op->cmd.buswidth;
    46			__entry->cmd_dtr = op->cmd.dtr;
    47			*((u8 *)__get_dynamic_array(op)) = op->cmd.opcode;
    48	
    49			__entry->addr_buswidth = op->addr.buswidth;
    50			__entry->addr_dtr = op->addr.dtr;
    51			for (i = 0; i < op->addr.nbytes; i++)
    52				((u8 *)__get_dynamic_array(op))[i + 1] =
    53					op->addr.val >> (8 * (op->addr.nbytes - i - 1));
    54	
    55			memset(((u8 *)__get_dynamic_array(op)) + op->addr.nbytes + 1,
    56			       0xff, op->dummy.nbytes);
    57	
    58			__entry->data_len = op->data.nbytes;
    59			__entry->data_buswidth = op->data.buswidth;
    60			__entry->data_dtr = op->data.dtr;
    61			if (op->data.dir == SPI_MEM_DATA_OUT)
    62				memcpy(__get_dynamic_array(data), op->data.buf.out,
    63				       __get_dynamic_array_len(data));
    64		),
    65	
    66		TP_printk("%s %u%s-%u%s-%u%s @%u Hz op=[%*phD] len=%u tx=[%*phD]",
    67			__get_str(name),
    68			__entry->cmd_buswidth, decode_dtr(__entry->cmd_dtr),
    69			__entry->addr_buswidth, decode_dtr(__entry->addr_dtr),
    70			__entry->data_buswidth, decode_dtr(__entry->data_dtr),
    71			__entry->max_freq,
    72			__get_dynamic_array_len(op), __get_dynamic_array(op),
    73			__entry->data_len,
    74			__get_dynamic_array_len(data), __get_dynamic_array(data))
    75	);
    76	
    77	TRACE_EVENT(spi_mem_stop_op,
    78		TP_PROTO(struct spi_mem *mem, const struct spi_mem_op *op),
    79		TP_ARGS(mem, op),
    80	
    81		TP_STRUCT__entry(
    82			__string(name, mem->name)
    83			__dynamic_array(u8, data, op->data.dir == SPI_MEM_DATA_IN ?
    84						  min(op->data.nbytes, 64) : 0)
    85			__field(u32, data_len)
    86		),
    87	
    88		TP_fast_assign(
    89			__assign_str(name, mem->name);
    90			__entry->data_len = op->data.nbytes;
    91			if (op->data.dir == SPI_MEM_DATA_IN)
    92				memcpy(__get_dynamic_array(data), op->data.buf.in,
    93				       __get_dynamic_array_len(data));
    94		),
    95	
    96		TP_printk("%s len=%u rx=[%*phD]",
    97			__get_str(name),
    98			__entry->data_len,
    99			__get_dynamic_array_len(data), __get_dynamic_array(data))
   100	);
   101	
   102	
   103	#endif /* _TRACE_SPI_MEM_H */
   104	
   105	/* This part must be outside protection */
 > 106	#include <trace/define_trace.h>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

